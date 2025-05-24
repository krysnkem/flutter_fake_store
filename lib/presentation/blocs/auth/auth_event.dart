import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({
    required this.username,
    required this.password,
  });
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}

class AuthCheckEvent extends AuthEvent {
  const AuthCheckEvent();
}
