part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizQuestionLoad extends QuizState {}

class QuizQuestionLoadSuccessState extends QuizState {
  List<QuizQuestion> questions;
  QuizQuestionLoadSuccessState({@required this.questions});
}

class QuizQuestionLoadFailureState extends QuizState {
  String message;
  QuizQuestionLoadFailureState({@required this.message});
}


class QuizStartedState extends QuizState {}
class QuizFinisedState extends QuizState {}
