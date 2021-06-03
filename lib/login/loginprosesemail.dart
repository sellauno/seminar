import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String email;

Future<SignInSignUpResult> createUser({String email, String pass}) async {
  await Firebase.initializeApp();
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    return SignInSignUpResult(user: result.user);
  } catch (e) {
    return SignInSignUpResult(message: e.toString());
  }
}

Future<SignInSignUpResult> signInWithEmail({String email, String pass}) async {
  await Firebase.initializeApp();
  try {
    UserCredential result =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return SignInSignUpResult(user: result.user);
  } catch (e) {
    return SignInSignUpResult(message: e.toString());
  }
}

void signOut() {
  _auth.signOut();
}

class SignInSignUpResult {
  final User user;
  final String message;
  SignInSignUpResult({this.user, this.message});
}
