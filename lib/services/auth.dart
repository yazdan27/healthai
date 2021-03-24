import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User getUser() => _auth.currentUser;

  Stream<User> get authStateChanges => _auth.authStateChanges();

  Stream<User> get user => _auth.authStateChanges();
  //
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      if (e.code == 'wrong-password') {
        return 'Invalid password';
      }
      if (e.code == 'user-not-found') {
        return 'Mail doesn\'t exist';
      }
      return null;
    }
  }

  //
  Future signUpWithEmailandPassword(String email, String password) async {
    print(email);
    print(password);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future signInWithGoogle() async {
  //   try {
  //     User user;
  //
  //     final GoogleSignInAccount account = await _googleSignIn.signIn();
  //
  //     final GoogleSignInAuthentication googleAuth =
  //         await account.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     final UserCredential userCredentials =
  //         await _auth.signInWithCredential(credential);
  //
  //     user = userCredentials.user;
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Future<User> signUpWithGoogle() async {
  //   try {
  //     GoogleSignInAccount account = await _googleSignIn.signIn();
  //     GoogleSignInAuthentication googleAuth = await account.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  //
  //     UserCredential result = await _auth.signInWithCredential(credential);
  //     User user = result.user;
  //
  //     var profile = await _db.collection('profiles').doc(user.uid).get();
  //
  //     print(profile);
  //     if (profile.data() == null) {
  //       print('DOEST EXIST');
  //       await _db.collection('profiles').doc(user.uid).set({
  //         'fullName': user.displayName,
  //         'avatar': user.photoURL,
  //       });
  //     }
  //
  //     return user;
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }

  Future signOut() async {
    try {
      return await _auth.signOut().then((_) {
        // _googleSignIn.signOut();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
