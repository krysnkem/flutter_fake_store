import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthLogoutLoadingState extends AuthState {}
class AuthCheckLoadingState extends AuthState {}
class AuthAuthenticatedState extends AuthState {
  final String username;
  AuthAuthenticatedState({required this.username});

  @override
  List<Object?> get props => [username];
}

class AuthUnauthenticatedState extends AuthState {
  final String? message;
  AuthUnauthenticatedState({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

