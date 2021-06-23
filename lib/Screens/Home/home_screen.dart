import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthai/Screens/BMR/BMR_screen.dart';
import 'package:healthai/constants.dart';
import 'package:healthai/services/auth.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
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
              tileColor: Color.fromRGBO(213, 213, 213, 1),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text('BMI Calculator'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BMR();
                    }),
                  ); //push
                })
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Hello ${user.email}'),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .limit(1)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? Container(child: Text("Your BMI will be displayed here!"))
                    : Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Text(dataSnapshot.data.docs.length.toString()),
                      );
              },
            ),
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
