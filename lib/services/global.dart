import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthai/services/database.dart';

class Global {
  static final Map models = {};

  static final UserData<User> profileRef = UserData<User>(collection: "users");


}
