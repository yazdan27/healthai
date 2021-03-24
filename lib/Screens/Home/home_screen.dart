import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthai/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:healthai/authentication_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
            Text('Hello ${user.email}'),
            ElevatedButton(
              onPressed: () {
                _auth.signOut();
              },
              child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}
