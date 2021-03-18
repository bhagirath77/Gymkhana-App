import 'dart:async';
import '../../Pedantic Pack/pedantic.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
part 'authentication_state.dart';

part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unauthenticated()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }


  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield* _mapAuthUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logout());
    }
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<CustomUser> _userSubscription;

  Stream<AuthenticationState> _mapAuthUserChangedToState(
      AuthenticationUserChanged event) async* {
    yield event.user == CustomUser.empty
        ? const AuthenticationState.unauthenticated()
        : AuthenticationState.authenticated(event.user);
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
