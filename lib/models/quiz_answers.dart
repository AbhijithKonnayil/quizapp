
class Answers {
  String answers;
  bool isTrue;

  Answers({this.answers, this.isTrue});

  Answers.fromJson(Map<String, dynamic> json) {
    answers = json['Answers'];
    isTrue = json['isTrue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answers'] = this.answers;
    data['isTrue'] = this.isTrue;
    return data;
  }
}
