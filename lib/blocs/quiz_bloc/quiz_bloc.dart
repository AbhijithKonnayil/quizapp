import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/models/quiz_questions_model.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';
import 'package:quiz_app/repositories/user_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizRepository quizRepository = QuizRepository();
  UserRepository userRepository;
  QuizBloc({@required this.userRepository});
  @override
  QuizState get initialState => QuizInitial();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is QuizQuestionLoadEvent) {
      try {
        yield QuizQuestionLoad();
        QuizModel quizModel = await quizRepository.getQuestions();
        yield QuizQuestionLoadSuccessState(questions: quizModel.quizQuestions);
      } catch (e) {
        yield QuizQuestionLoadFailureState(message: e.toString());
      }
    } else if (event is QuizStartedEvent) {
      yield QuizStartedState();
    } else if (event is QuizFinishedEvent) {
      yield QuizFinisedState();
    }
  }
}
