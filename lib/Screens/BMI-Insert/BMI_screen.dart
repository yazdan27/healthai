import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:healthai/Screens/Home/home_screen.dart';
import 'package:healthai/constants.dart';

class BMI extends StatefulWidget {
  const BMI({Key key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  @override
  TextEditingController weight = new TextEditingController();
  TextEditingController height = new TextEditingController();
  TextEditingController age = new TextEditingController();
  String weightHintText = "Weight";
  String heightHintText = "Height";
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, kPrimaryLightColor],
                  stops: [0.00001, 1],
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }),
                ); //push
              },
            ),
            ListTile(
                tileColor: Color.fromRGBO(213, 213, 213, 1.0),
                title: Text('BMI Calculator'),
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('BMI'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(70, 70, 70, 1),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Text('What\'s your weight?', textAlign: TextAlign.center),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: Column(
                  children: [
                    TextField(
                        controller: weight,
                        decoration: InputDecoration(
                            hintText: weightHintText, counterText: ''),
                        maxLength: 3),
                    Text('Kilogram'),
                  ],
                ),
              ),
              Text('What\'s your height?', textAlign: TextAlign.center),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
                child: Column(
                  children: [
                    TextField(
                        controller: height,
                        decoration: InputDecoration(
                            hintText: heightHintText, counterText: ''),
                        maxLength: 3),
                    Text('Centimeter'),
                  ],
                ),
              ),
              Text('How old are you?', textAlign: TextAlign.center),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(
                            hintText: 'Age (optional)', counterText: ''),
                        maxLength: 3),
                    Text('Years old'),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (weight.text != "" && height.text != "") {
                      Map<String, dynamic> data = {
                        "Weight": weight.text,
                        "Height": height.text,
                        "Age": age.text};
                      FirebaseFirestore.instance.collection("users").add(data);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        weightHintText = "Please fill in your weight";
                        heightHintText = "Please fill in your height";
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
