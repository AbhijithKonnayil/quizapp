import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/models/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => null;
}

class AuthInitialState extends AuthState {}

class AuthenticatedState extends AuthState {
  User user;
  AuthenticatedState({@required this.user});
}

class UnAuthenticatedState extends AuthState {}
