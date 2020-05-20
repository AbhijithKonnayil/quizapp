import 'package:quiz_app/models/quiz_answers.dart';

class QuizQuestions {
  String questions;
  List<Answers> answers;

  QuizQuestions({this.questions, this.answers});

  QuizQuestions.fromJson(Map<String, dynamic> json) {
    questions = json['Questions'];
    if (json['Answers'] != null) {
      answers = new List<Answers>();
      json['Answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Questions'] = this.questions;
    if (this.answers != null) {
      data['Answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
