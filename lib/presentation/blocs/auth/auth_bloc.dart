import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/data/models/auth/saved_user.dart';
import 'package:flutter_fake_store/data/models/result.dart';
import 'package:flutter_fake_store/data/repositories/data_repository.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DataRepository _dataRepository;

  AuthBloc({required DataRepository dataRepository})
      : _dataRepository = dataRepository,
        super(AuthInitState()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthCheckEvent>(_onCheckAuth);
  }

  FutureOr<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final result = await _dataRepository.login(
        username: event.username,
        password: event.password,
        email: '',
      );
      if (result is Success) {
        emit(AuthAuthenticatedState(username: event.username));
      } else if (result is Failure) {
        emit(AuthUnauthenticatedState(message: (result as Failure).message));
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      log('Login error: $e');
    }
  }

  FutureOr<void> _onLogout(
      AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLogoutLoadingState());
    try {
      final result = await _dataRepository.logout();
      if (result is Success) {
        emit(AuthUnauthenticatedState());
      } else if (result is Failure) {
        emit(AuthErrorState(message: (result).message));
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      log('Logout error: $e');
    }
  }

  FutureOr<void> _onCheckAuth(
      AuthCheckEvent event, Emitter<AuthState> emit) async {
    final result = await _dataRepository.isLoggedIn();
    try {
      if (result is Success) {
        final (bool isLoggedIn, SavedUser savedUser) = (result as Success).data;
        if (isLoggedIn) {
          emit(
            AuthAuthenticatedState(username: savedUser.username),
          );
        } else {
          emit(AuthUnauthenticatedState());
        }
      } else if (result is Failure) {
        emit(AuthErrorState(message: (result as Failure).message));
      }
    } catch (e) {
      emit(AuthErrorState(message: e.toString()));
      log('Check auth error: $e');
    }
  }
}
