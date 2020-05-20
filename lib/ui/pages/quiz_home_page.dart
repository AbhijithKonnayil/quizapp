import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:quiz_app/blocs/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_app/models/quiz_questions_model.dart';
import 'package:quiz_app/theme/theme.dart';
import 'package:quiz_app/ui/widgets/custom_widgets.dart';

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  List<QuizQuestion> questions;
  QuizBloc quizBloc;
  List<Widget> swiperPages = [];
  List<int> markedIndex;
  SwiperController swiperController = SwiperController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizBloc = BlocProvider.of<QuizBloc>(context);
    quizBloc.add(QuizQuestionLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: QuizAppTheme.blue3,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /* FlatButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        "Logout",
                      ),
                    ),
                  ) */
                ],
              ),
              Expanded(
                child: BlocBuilder<QuizBloc, QuizState>(
                  builder: (context, state) {
                    if (state is QuizInitial) {
                      return Container();
                    } else if (state is QuizQuestionLoad) {
                      return Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                        ),
                      );
                    } else if (state is QuizQuestionLoadSuccessState) {
                      questions = state.questions;
                      markedIndex = List<int>(questions.length);
                      return buildInitialPage();
                    } else if (state is QuizQuestionLoadFailureState) {
                      return Text(state.message);
                    } else if (state is QuizStartedState) {
                      return buildquizUi();
                    } else if (state is QuizFinisedState) {
                      return buildFinalPage();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildquizUi() {
    buildQuestionPages();
    return Center(
      child: Container(
        child: Swiper.children(
          controller: swiperController,
          loop: false,
          scrollDirection: Axis.horizontal,
          children: swiperPages,
        ),
      ),
    );
  }

  Widget buildInitialPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Rules",style: TextStyle(color:Colors.white,fontSize: 25),),
        Text("Correct answer ->  10 Points",style: TextStyle(color:Colors.white,fontSize: 15,),textAlign: TextAlign.left,),
        Text("Wrong answer ->  -1 Points",style: TextStyle(color:Colors.white,fontSize: 15,),textAlign: TextAlign.left,),
        Text("Unattended answer ->  0 Points",style: TextStyle(color:Colors.white,fontSize: 15,),textAlign: TextAlign.left,),
        SizedBox(height: 25,),
        Container(
          width: double.infinity,
          child: FlatButton(
            onPressed: () => quizBloc.add(QuizStartedEvent()),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Start Quiz"),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuestionPages() {
    var questionPages = List<Widget>.generate(
        questions.length,
        (questionIndex) => Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Q ${questionIndex + 1}. ${questions[questionIndex].question}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Options(
                        answers: questions[questionIndex].answers,
                        selectedIndex: markedIndex[questionIndex],
                        markAnswer: (int answerIndex) {
                          markedIndex[questionIndex] = answerIndex;
                          print(markedIndex);
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      questionIndex != 0
                          ? buildNavigationButton(
                              "Previous", () => swiperController.previous())
                          : Container(),
                      questionIndex != questions.length - 1
                          ? buildNavigationButton(
                              "Next", () => swiperController.next())
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "Finish",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onPressed: () => quizBloc.add(QuizFinishedEvent()),
                  )
                ],
              ),
            ));
    swiperPages = swiperPages + questionPages;
  }

  Widget buildFinalPage() {
    int score = 0;
    int i = 0;
    int attended = 0, correct = 0, wrong = 0;
    for (var each in markedIndex) {
      if (each != null) {
        attended = attended + 1;
        if (questions[i].answers[each].isTrue) {
          correct = correct + 1;
        } else {
          wrong = wrong + 1;
        }
      }
      i = i + 1;
    }
    score = (correct * 10) - (wrong * 1);
    return Center(
      child: Container(
        width: double.infinity,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Text(
                      "Result",
                      style: TextStyle(fontSize: 40)),
                      Divider(),
                    Text("Attended Questions : $attended"),
                    Text("Correct Answers : $correct"),
                    Text("Wrong Answers : $wrong"),
                    Text(
                      "Score : $score",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ))),
          ],
        )),
      ),
    );
  }

  Widget buildNavigationButton(String label, Function onClickFn) {
    return Expanded(
      child: FlatButton(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: QuizAppTheme.blueShade32,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Text(
            label,
            style: TextStyle(color: Colors.white),
          )),
        ),
        onPressed: onClickFn,
      ),
    );
  }
}
