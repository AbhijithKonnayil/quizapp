import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/models/user.dart';

class UserRepository {
  FirebaseUser user;
  FirebaseAuth firebaseAuth;

  initFirebaseAuth() async {
    firebaseAuth = FirebaseAuth.instance;
  }

  loginUser(String phone) async {
    try {
      var user = await verifyPhone(phone);
      return user;
    } catch (e) {
      throw (e);
    }
  }

  getUser() async {}
  isLoggedIn() async {
    user = await firebaseAuth.currentUser();
    return user != null;
  }

  logoutUser() async {
    await firebaseAuth.signOut();
  }

  Future<void> verifyPhone(phone) async {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {};
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {};
    final PhoneVerificationFailed verificationFailed =await (AuthException authException) {
      throw (authException.message);
    };
    final PhoneVerificationCompleted verificationCompleted = await (AuthCredential auth) async {
      var authResult = await firebaseAuth.signInWithCredential(auth);
      if (authResult.user != null) {
        user = authResult.user;
        return user;
      } else {
        return null;
      }
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
