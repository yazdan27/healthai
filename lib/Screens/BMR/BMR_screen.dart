import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:healthai/Screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthai/services/auth.dart';
import 'package:healthai/constants.dart';
import 'package:provider/provider.dart';

class BMR extends StatefulWidget {
  const BMR({Key key}) : super(key: key);

  @override
  _BMRState createState() => _BMRState();
}

class _BMRState extends State<BMR> {
  @override

    TextEditingController weight = new TextEditingController();
    TextEditingController height = new TextEditingController();
    TextEditingController age = new TextEditingController();
    String weightHintText = "Weight in kilograms";
    String heightHintText = "Height in centimeters";
    String ageHintText = "Age in years";
    double BMRValue = 0;
    Widget build(BuildContext context) {
      var user = Provider.of<User>(context);

      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kPrimaryColor.withOpacity(0.85),
                      kPrimaryLightColor
                    ],
                    stops: [0.00001, 1],
                  ),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 40,
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
                      return SearchScreen();
                    }),
                  ); //push
                },
              ),
              ListTile(
                  tileColor: Color.fromRGBO(220, 220, 220, 0.8),
                  title: Text('BMR Calculator'),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                tileColor: kPrimaryColor.withOpacity(0.2),
                title: Text('${user.email}'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('BMR'),
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
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
                  child: Column(
                    children: [
                      TextField(
                          controller: weight,
                          decoration: InputDecoration(
                              hintText: weightHintText, counterText: ''),
                          maxLength: 4),
                    ],
                  ),
                ),
                Text('What\'s your height?', textAlign: TextAlign.center),
                Container(
                  margin:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
                  child: Column(
                    children: [
                      TextField(
                          controller: height,
                          decoration: InputDecoration(
                              hintText: heightHintText, counterText: ''),
                          maxLength: 3),
                    ],
                  ),
                ),
                Text('How old are you?', textAlign: TextAlign.center,),
                Container(
                  margin:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      TextField(
                          controller: age,
                          decoration: InputDecoration(
                              hintText: ageHintText, counterText: ''),
                          maxLength: 3),

                    ],
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                  child: ElevatedButton(
                    child: Text('Calculate'),
                    onPressed: () {
                      if (weight.text != "" && height.text != "") {
                        setState(() {
                          BMRValue =
                              88.362 + 13.397 * double.parse(weight.text) +
                                  4.799 * double.parse(height.text) -
                                  5.677 * double.parse(age.text);
                        });


                        /*Map<String, dynamic> data = {
                        "Weight": weight.text,
                        "Height": height.text,
                        "Age": age.text
                      };
                      FirebaseFirestore.instance.collection("users").add(data);
                      Navigator.pop(context);
                      Navigator.pop(context);*/
                      } else {
                        setState(() {
                          weightHintText = "Please fill in your weight";
                          heightHintText = "Please fill in your height";
                          ageHintText = "please fill in your age";
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: [
                      TextField(
                        readOnly: true,
                        controller: TextEditingController(text: BMRValue
                            .roundToDouble().toString() + ' Calories/day'),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
