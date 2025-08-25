import 'package:firebase_auth/firebase_auth.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/model/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> emailSignIn(String email, String password) async {
    String formattedEmail =
        email.contains("@gmail.com") ? email : "$email@gmail.com";
    try {
      UserCredential fbUser = await _auth.signInWithEmailAndPassword(
          email: formattedEmail, password: password);
      if (fbUser.user != null) {
        currentUser.id = fbUser.user?.uid ?? "";
        return "";
      }
      return "error";
    } on FirebaseAuthException catch (error) {
      _auth.signOut();
      return error.message ?? error.code;
    }
  }

  Future<void> checkUser() async {
    currentUser.id = _auth.currentUser?.uid ?? "";
  }

  Future<String> emailSignUp() async {
    try {
      UserCredential fbUser = await _auth.createUserWithEmailAndPassword(
          email: currentUser.email, password: currentUser.initialPassword);
      if (fbUser.user != null) {
        currentUser.id = fbUser.user!.uid;
        await fbUser.user?.sendEmailVerification();
        return "";
      }
      return "error";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<String> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "";
    } on FirebaseAuthException catch (error) {
      return error.message ?? error.code;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
    currentUser = UserModel();
  }
}
