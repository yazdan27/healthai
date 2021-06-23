import 'package:flutter/material.dart';
import 'package:healthai/components/text_field_container.dart';
import 'package:healthai/constants.dart';

TextEditingController emailController = new TextEditingController();






class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController ctrl;

  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: ctrl,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
