import 'package:firebase_services/Services/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_services/Services/database_services.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFailure implements Exception {}

class EmailInvalid implements Exception {}

class LogoutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<CustomUser> get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUserToUser);
  }

  CustomUser get currentCustomUser {
    var user = _firebaseAuth.currentUser;
    return _firebaseUserToUser(user);
  }

  CustomUser _firebaseUserToUser(User firebaseUser) {
    return firebaseUser == null
        ? CustomUser.empty
        : CustomUser(
            id: firebaseUser.uid,
            email: firebaseUser.email,
            photoUrl: firebaseUser.photoURL,
            name: firebaseUser.displayName);
  }

  Future<void> logInWithGoogle() async {
    try {
      var _googleSignInAccount = await _googleSignIn.signIn();
      final googleAuthentication = await _googleSignInAccount.authentication;
      if (_googleSignInAccount.email.contains('@iitj.ac.in')) {
        final credentials = GoogleAuthProvider.credential(
            idToken: googleAuthentication.idToken,
            accessToken: googleAuthentication.accessToken);
        final authResult =
            await _firebaseAuth.signInWithCredential(credentials);
        if (authResult.additionalUserInfo.isNewUser) {
          await DatabaseServices().addUser(user: authResult.user);
        }
      } else {
        await _googleSignIn.signOut();
        throw EmailInvalid();
      }
    } catch (e) {
      print(' ${e.toString()} error occurred');
      if (e == EmailInvalid()) {
        throw EmailInvalid();
      } else {
        throw LoginFailure();
      }
    }
  }

  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      print(('${e.toString()} error occurred'));
      throw LogoutFailure();
    }
  }
}
