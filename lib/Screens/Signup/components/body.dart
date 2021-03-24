import 'package:flutter/material.dart';
import 'package:healthai/Screens/Login/login_screen.dart';
import 'package:healthai/Screens/Signup/components/background.dart';
import 'package:healthai/services/auth.dart';
import 'package:healthai/components/already_have_an_account_acheck.dart';
import 'package:healthai/components/rounded_button.dart';
import 'package:healthai/components/rounded_input_field.dart';
import 'package:healthai/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:healthai/authentication_service.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  AuthService _auth = AuthService();
  String _error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
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
              text: "SIGNUP",
              press: () async {
                var result = _auth.signUpWithEmailandPassword(
                    emailController.text, passwordController.text);
                if (result == null) {
                  print('error');
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AuthenticationWrapper()),
                      (route) => false);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => WrapperUser()));
                }

                print(emailController.text);
                print(passwordController.text);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            /* OrDivider() ,*/
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                 SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
