import 'package:quiz_app/models/quiz_questions_model.dart';

class QuizModel {
  String appName;
  String eventConductedBy;
  List<QuizQuestions> quizQuestions;

  QuizModel({this.appName, this.eventConductedBy, this.quizQuestions});

  QuizModel.fromJson(Map<String, dynamic> json) {
    appName = json['AppName'];
    eventConductedBy = json['Event Conducted By'];
    if (json['Quiz Questions'] != null) {
      quizQuestions = new List<QuizQuestions>();
      json['Quiz Questions'].forEach((v) {
        quizQuestions.add(new QuizQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppName'] = this.appName;
    data['Event Conducted By'] = this.eventConductedBy;
    if (this.quizQuestions != null) {
      data['Quiz Questions'] =
          this.quizQuestions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
