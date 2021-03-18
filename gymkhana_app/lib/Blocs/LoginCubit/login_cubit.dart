import 'package:bloc/bloc.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
enum LoginState { Static, InProgress,LoginFailure,InvalidEmail}

class LoginCubit extends Cubit<LoginState> {
   LoginCubit({@required AuthenticationRepository authenticationRepository})
      : this._authenticationRepository = authenticationRepository,
        super(LoginState.Static);

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithGoogle() async{
    emit(LoginState.InProgress);
    try{
      await _authenticationRepository.logInWithGoogle();
      emit(LoginState.Static);
    }on EmailInvalid{
      print('email Invalid');
      emit(LoginState.InvalidEmail);
    }on LoginFailure{
      emit(LoginState.LoginFailure);
    }on NoSuchMethodError{
      emit(LoginState.Static);
    }
  }
}
