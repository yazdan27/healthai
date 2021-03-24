// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthenticationService {
//   final FirebaseAuth _auth;
//
//   AuthenticationService(this._auth);
//
//   Stream<User> get authStateChanges => _auth.authStateChanges();
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
//
//   Future<String> signIn({String email, String password}) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Signed in";
//     } on FirebaseAuthException catch (e) {
//       return e.code;
//     }
//   }
//
//   // Future signInWithEmailandPassword(String email, String password) async {
//   //   try {
//   //     UserCredential result = await _auth.signInWithEmailAndPassword(
//   //         email: email, password: password);
//   //     User user = result.user;
//   //     return user;
//   //   } catch (e) {
//   //     if (e.code == 'wrong-password') {
//   //       return 'Invalid password';
//   //     }
//   //     if (e.code == 'user-not-found') {
//   //       return 'Mail doesn\'t exist';
//   //     }
//   //     return null;
//   //   }
//   // }
//   //
//   // Future signUpWithEmailandPassword(String email, String password) async {
//   //   print(email);
//   //   print(password);
//   //   try {
//   //     UserCredential result = await _auth.createUserWithEmailAndPassword(
//   //         email: email, password: password);
//   //     User user = result.user;
//   //
//   //     return user;
//   //   } catch (e) {
//   //     print(e.toString());
//   //     return null;
//   //   }
//   // }
//
//   Future<String> signUp({String email, String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Signed up";
//     } on FirebaseAuthException catch (e) {
//       return e.code;
//     }
//   }
// }
