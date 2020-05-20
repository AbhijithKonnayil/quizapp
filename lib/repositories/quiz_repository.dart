import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz_app/models/quiz_model.dart';

class QuizRepository {
  getQuestions() async {
    try{
      var response = await get('http://www.mocky.io/v2/5ebd2f5f31000018005b117f');
      if(response.statusCode==200){
        var jsonObject = json.decode(response.body);
      QuizModel quizModel = QuizModel.fromJson(jsonObject); 
          
      return quizModel;
      }
    }catch(e){
      throw(e);
    }
  }
}
