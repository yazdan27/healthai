import 'package:flutter/material.dart';
import 'package:healthai/Screens/Login/components/background.dart';
import 'package:healthai/Screens/Signup/signup_screen.dart';
import 'package:healthai/services/auth.dart';
import 'package:healthai/components/already_have_an_account_acheck.dart';
import 'package:healthai/components/rounded_button.dart';
import 'package:healthai/components/rounded_input_field.dart';
import 'package:healthai/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              ctrl: emailController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              ctrl: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              press: () async {
                var result = await _auth.signInWithEmailandPassword(
                    emailController.text, passwordController.text);
                if (result is String) {
                  setState(() {
                    _error = result;
                  });
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AuthenticationWrapper()),
                      (route) => false);
                }

                print(emailController.text);
                print(passwordController.text);
              },
              text: "LOGIN",
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
