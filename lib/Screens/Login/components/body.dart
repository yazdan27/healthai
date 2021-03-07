import 'package:flutter/material.dart';
import 'package:healthai/Screens/Home/home_screen.dart';
import 'package:healthai/Screens/Login/components/background.dart';
import 'package:healthai/Screens/Signup/signup_screen.dart';
import 'package:healthai/authentication_service.dart';
import 'package:healthai/components/already_have_an_account_acheck.dart';
import 'package:healthai/components/rounded_button.dart';
import 'package:healthai/components/rounded_input_field.dart';
import 'package:healthai/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);



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
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              press: () {
                context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim()
                );
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