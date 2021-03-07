import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthai/authentication_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>()..signOut();
                }, child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}
