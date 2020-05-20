import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/blocs/login_bloc/login_bloc.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/repositories/user_repository.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/ui/pages/quiz_home_page.dart';
import 'package:quiz_app/ui/widgets/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  UserRepository userRepository;
  LoginPage({@required this.userRepository});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: QuizAppTheme.blueShade32),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Flutter Kerala ",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset('images/image1.png'),
                    ),
                  ),
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BaseApp(userRepository: loginBloc.userRepository,);
                        }));
                      }
                    },
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginInitial) {
                        return buildPhoneField();
                      } else if (state is LoginLoadState) {
                        return Center(
                            child: SpinKitCircle(
                          size: 50,
                          color: Colors.white,
                        ));
                      } else if (state is LoginFailureState) {
                        return Center(
                            child: Text(
                          "Login Failed",
                          style: TextStyle(color: Colors.white),
                        ));
                      } else if (state is LoginSuccessState) {
                        return Container();
                      }
                    }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "image credits : freepik.com",
                        style: TextStyle(fontSize: 10, color: Colors.black38),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildPhoneField() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(child: TextBox(
            onChanged: (value) {
              phoneController.text = value;
            },
          )),
          MaterialButton(
            child: Icon(Icons.arrow_forward),
            color: QuizAppTheme.blue0,
            onPressed: () {
              loginBloc
                  .add(LoginButtonClicked(phone: "+91${phoneController.text}"));
            },
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}
