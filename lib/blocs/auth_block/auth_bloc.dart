import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/blocs/auth_block/auth_event.dart';
import 'package:quiz_app/blocs/auth_block/auth_state.dart';
import 'package:quiz_app/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AuthBloc({@required UserRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        var isLoggedIn = await userRepository.isLoggedIn();
        if (isLoggedIn) {
          var user = await userRepository.getUser(); //current User
          yield AuthenticatedState(user: user);
        } else {
          yield UnAuthenticatedState();
        }
      } catch (e) {
        yield UnAuthenticatedState();
      }
    }
    
  }
}
