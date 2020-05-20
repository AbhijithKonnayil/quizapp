part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  List<Object> get props => throw UnimplementedError();
}

class QuizQuestionLoadEvent extends QuizEvent {}

class QuizStartedEvent extends QuizEvent {}

class QuizFinishedEvent extends QuizEvent {}

class LogOutEvent extends QuizEvent {}
