import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
    @override
  List<Object> get props => null;

}

class AppStartedEvent extends AuthEvent{

}
class LogOutEvent extends AuthEvent{

}
