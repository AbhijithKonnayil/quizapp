import 'package:quiz_app/models/quiz_answers.dart';

class QuizQuestion {
  String question;
  List<Answers> answers;

  QuizQuestion({this.question, this.answers});

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    question = json['Questions'];
    if (json['Answers'] != null) {
      answers = new List<Answers>();
      json['Answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Questions'] = this.question;
    if (this.answers != null) {
      data['Answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
