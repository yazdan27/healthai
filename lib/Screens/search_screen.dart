import 'package:flutter/material.dart';
import 'package:healthai/Screens/meals_screen.dart';
import 'package:healthai/models/meal_plan_model.dart';
import 'package:healthai/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:healthai/services/auth.dart';
import 'package:healthai/constants.dart';
import 'package:healthai/Screens/BMR/BMR_screen.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AuthService _auth = AuthService();


    List<String> _diets = [
      'None',
      'Gluten Free',
      'Ketogenic',
      'Lacto-Vegetarian',
      'Ovo-Vegetarian',
      'Vegan',
      'Pescetarian',
      'Paleo',
      'Primal',
      'Whole30',
    ];

    double _targetCalories = 2250;
    String _diet = 'None';

    void _searchMealPlan() async {
      MealPlan mealPlan = await APIService.instance.generateMealPlan(
        targetCalories: _targetCalories.toInt(),
        diet: _diet.toString(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MealsScreen(mealPlan: mealPlan),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      var user = Provider.of<User>(context);
      var email = '${user.email}';

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        drawer:
        Drawer(
          child:
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration:
                BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryColor, kPrimaryLightColor],
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
                tileColor: Color.fromRGBO(220, 220, 220, 0.8),
                title: Text('Home'),
                onTap: () {
                  setState(() {

                  });

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
                  }),
              ListTile(
                tileColor: kPrimaryColor.withOpacity(0.2),
                title: Text(email),
              )
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=format&fit=crop&w=1350&q=80',
                ),
                fit: BoxFit.fill
            ),
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Meal Planner',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  RichText(
                    text: TextSpan(
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 25),
                      children: [
                        TextSpan(
                          text: _targetCalories.truncate().toString(),
                          style: TextStyle(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' cal',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Theme
                          .of(context)
                          .primaryColor,
                      activeTrackColor: Theme
                          .of(context)
                          .primaryColor,
                      inactiveTrackColor: Colors.lightBlue[100],
                      trackHeight: 6.0,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 4500.0,
                      value: _targetCalories,
                      onChanged: (value) =>
                          setState(() {
                            _targetCalories = value.round().toDouble();
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: DropdownButtonFormField(
                      items: _diets.map((String priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Diet',
                        labelStyle: TextStyle(fontSize: 18.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _diet = value;
                        });
                      },
                      value: _diet,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 8.0,
                      ),
                      primary: Theme
                          .of(context)
                          .primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: _searchMealPlan,
                  ),
                  /*TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 8.0,
                      ),
                      primary: Theme
                          .of(context)
                          .primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Back To Meals',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if( MealPlan != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MealsScreen();
                          }),
                        );
                      }//push
                    },
                  ),*/
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 8.0,
                      ),
                      primary: Theme
                          .of(context)
                          .primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

