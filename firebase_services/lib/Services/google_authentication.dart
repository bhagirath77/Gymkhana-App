import 'package:firebase_services/Services/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFailure implements Exception {}

class LogoutFailure implements Exception {}

class AuthenticationServices {
  AuthenticationServices({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<CustomUser> get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUserToUser);
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
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleAuthentication = await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken);
      await _firebaseAuth.signInWithCredential(credentials);
    } catch (e) {
      print(' ${e.toString()} error occurred');
      throw LoginFailure();
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
