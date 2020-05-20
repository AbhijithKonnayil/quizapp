import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  Function updateUser;
  LoginBloc({@required this.userRepository, @required this.updateUser});
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonClicked) {
      try {
        yield LoginLoadState();
        var response = await userRepository.loginUser(event.phone);
        if (response != null) {
          yield LoginSuccessState();
        } else {
          throw ('Login Error');
        }
      } catch (e) {
        yield LoginFailureState();
        await Future.delayed(Duration(seconds: 3));
        yield LoginInitial();
      }
    }
  }
}
