import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthai/Screens/Welcome/welcome_screen.dart';
import 'package:healthai/services/auth.dart';
import 'package:healthai/constants.dart';
import 'package:provider/provider.dart';
import 'package:healthai/Screens/search_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<AuthService>(
        //   create: (_) => AuthService(FirebaseAuth.instance),
        // ),
        // StreamProvider(
        //   create: (context) => context.read<AuthService>().authStateChanges,
        //   initialData: null,
        // ),
        StreamProvider<User>.value(value: AuthService().user),
        // StreamProvider<User>.value(value: Global.profileRef.documentStream),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HealthAI',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    var user = Provider.of<User>(context);
    //return user == null ? WelcomeScreen() : HomeScreen();
    return user == null ? WelcomeScreen() : SearchScreen();
  }
}
