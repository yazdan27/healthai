import 'package:firebase_auth/firebase_auth.dart';



class AuthenticationService{
  final FirebaseAuth _auth;

  AuthenticationService(this._auth);

  Stream<User> get authStateChanges => _auth.authStateChanges();
  
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String>signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> signUp({String email, String password}) async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

}