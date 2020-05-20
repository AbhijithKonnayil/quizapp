import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_answers.dart';
import 'package:quiz_app/theme/theme.dart';

class TextBox extends StatefulWidget {
  Function onChanged;
  TextBox({@required this.onChanged});
  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Center(
        child: TextField(
          onChanged: widget.onChanged,
          keyboardType: TextInputType.number,
          style: TextStyle(color: QuizAppTheme.blue2, fontSize: 20),
          decoration: InputDecoration(
            prefixText: "+91",
            prefixStyle: TextStyle(color: QuizAppTheme.blue2),
            hintText: 'Mobile Number',
            icon: Icon(
              Icons.phone,
              color: QuizAppTheme.blue2,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  String label;
  Button({@required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: QuizAppTheme.blueShade10),
      child: Center(
          child: Text(
        label,
        style: TextStyle(fontSize: 20, color: QuizAppTheme.blue3),
      )),
    );
  }
}

class Options extends StatefulWidget {
  List<Answers> answers;
  Function markAnswer;
  int selectedIndex;
  Options({@required this.answers, this.markAnswer, this.selectedIndex});
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  BoxDecoration boxDecorations = BoxDecoration(
      color: Colors.white,
      border: Border.all(
          color: QuizAppTheme.blue1, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10)));

  BoxDecoration selectedBoxDecorations = BoxDecoration(
      gradient: QuizAppTheme.blueShade10,
      borderRadius: BorderRadius.all(Radius.circular(10)));
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        buildOptionButton(0),
        SizedBox(
          height: 10,
        ),
        buildOptionButton(1),
        SizedBox(
          height: 10,
        ),
        buildOptionButton(2),
        SizedBox(
          height: 10,
        ),
        buildOptionButton(3)
      ],
    );
  }

  buildOptionButton(int index) {
    var decorations;
    if (index == widget.selectedIndex) {
      decorations = selectedBoxDecorations;
    } else {
      decorations = boxDecorations;
    }
    return FlatButton(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: decorations,
        child: Center(
          child: Text(
            widget.answers[index].answers,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: () {
        setState(() {
          if (widget.selectedIndex == index) {
            widget.selectedIndex = null;
          } else {
            widget.selectedIndex = index;
          }

          print("option cus widget $index");
          widget.markAnswer(widget.selectedIndex);
        });
      },
    );
  }
}
