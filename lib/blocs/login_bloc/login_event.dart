part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => null;
}

class LoginButtonClicked extends LoginEvent {
  String phone;
  LoginButtonClicked({@required this.phone});
}

