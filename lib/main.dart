import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/auth_block/auth_bloc.dart';
import 'package:quiz_app/blocs/auth_block/auth_event.dart';
import 'package:quiz_app/blocs/auth_block/auth_state.dart';
import 'package:quiz_app/blocs/login_bloc/login_bloc.dart';
import 'package:quiz_app/blocs/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_app/repositories/user_repository.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/ui/pages/login_page.dart';
import 'package:quiz_app/ui/pages/quiz_home_page.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    userRepository.initFirebaseAuth();
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(userRepository: userRepository)
              ..add(AppStartedEvent()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: userRepository,
              updateUser: (user) {
                userRepository.user = user;
              },
            ),
          ),
          BlocProvider<QuizBloc>(create: (context) => QuizBloc(userRepository: userRepository)),
        ],
        child: MaterialApp(
          title: 'Flutter Kerala QuizMaster',
          theme: ThemeData(
            primaryColor: QuizAppTheme.blue3,
          ),
          home: BaseApp(
            userRepository: userRepository,
          ),
        ));
  }
}

class BaseApp extends StatelessWidget {
  UserRepository userRepository;
  BaseApp({@required this.userRepository});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthInitialState) {
        return Scaffold(
          body: Container(color: Colors.white),
        );
      } else if (state is AuthenticatedState) {
        return QuizHomePage();
      } else if (state is UnAuthenticatedState) {
        return LoginPage(userRepository: userRepository);
      }
    });
  }
}
