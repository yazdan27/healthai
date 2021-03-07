import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential credential = await _auth.signInAnonymously();
      User user =  credential.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }

  }


  //sign in w email & pass

  //register w email & pass

  //sign out

}
