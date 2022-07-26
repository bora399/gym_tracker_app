import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_app/pages/settings_page.dart';
import 'package:gym_app/pages/weight_tracker_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_app/utils/constants.dart';
import 'package:gym_app/utils/widget_functions.dart';
import 'package:gym_app/pages/workouts_page.dart';

import '../pages/1rm_page.dart';
import '../pages/1rm_tracker_page.dart';


class HomePage extends StatefulWidget {
  String name;
  String currentWeight;
  String targetWeight;

  HomePage({Key key,
  this.name, this.currentWeight, this.targetWeight,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

  String name2;
  String currentWeight2;
  String targetWeight2;
  bool languageValue = false;
  Future<bool> value;
  var data;

  Future<bool> myFunc()async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if(_prefs.getBool("languageValue") == null){
    return Future.value(false);;
  }
  else {
    if (_prefs.getBool("languageValue") == true) {
      return Future.value(true);;
    }
    else {
      return Future.value(false);;
    }
  }
  }

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  Future<void> readySharedPreferences() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    name2 = _prefs.getString("username");
    currentWeight2 = _prefs.getString("currentWeight");
    targetWeight2 = _prefs.getString("targetWeight");
    setState((){
      saveData();
    });
  }



  Future<bool> getMockData() {
    return Future.value(myFunc());
  }

  Future<void> saveData() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(widget.name != null){
      name2 = widget.name;
      currentWeight2 = widget.currentWeight;
      targetWeight2 = widget.targetWeight;
    }
    if(widget.name == null){
      name2=name2;
      currentWeight2=currentWeight2;
      targetWeight2=targetWeight2;
    }
    _prefs.setString("username", name2);
    _prefs.setString("currentWeight",currentWeight2);
    _prefs.setString("targetWeight",targetWeight2);
  }

  @override
  void initState(){
    super.initState();
    readySharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
        body:FutureBuilder<bool>(
          future:myFunc(),
          builder: (BuildContext context, AsyncSnapshot<bool> asyncSnapshot,) {
            if(asyncSnapshot.hasData){
              return Column(
                children: [
                  addVerticalSpace(size.height/60),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:size.width/18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(asyncSnapshot.data?"Welcome":"Hoş geldiniz",style:themeData.textTheme.subtitle1),
                        IconButton(
                            onPressed:(){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage() ));
                            },
                            icon:Icon(Icons.settings,color:COLOR_ORANGE,size:28)
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:size.width/18),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(child: Text(name2.toLowerCase(),style:themeData.textTheme.subtitle2)),
                      ],
                    ),
                  ),
                  addVerticalSpace(size.height/10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:15),
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => WorkoutPage()));
                      },
                      child: Card(
                        color:COLOR_SEARCH_BLACK,
                        child:ListTile(
                          title:Text(asyncSnapshot.data?"The best workouts for you":"Senin için en iyi antrenmanlar",style:themeData.textTheme.bodyText2),
                          subtitle:Text(asyncSnapshot.data?"It's incldue the workouts of legends, like zyzz":"Bu, zyzz gibi efsanelerin programlarını içeriyor",style:themeData.textTheme.bodyText1),
                          trailing:Icon(Icons.fitness_center_rounded,color:COLOR_WHITE,size:27),
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpace(size.height/30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:15),
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => OneRMPage()));
                      },
                      child: Card(
                        color:COLOR_SEARCH_BLACK,
                        child:ListTile(
                          title:Text(asyncSnapshot.data?"1RM Calculator":"1RM Hesaplayıcı",style:themeData.textTheme.bodyText2),
                          subtitle:Text(asyncSnapshot.data?"You can check your one rap max with this":"Bununla 1 tekrar max'ını ölçebilirsin",style:themeData.textTheme.bodyText1),
                          trailing:Icon(Icons.fitness_center_rounded,color:COLOR_WHITE,size:27),
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpace(size.height/30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:15),
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => WeightTracker()));
                      },
                      child: Card(
                        color:COLOR_SEARCH_BLACK,
                        child:ListTile(
                          title:Text(asyncSnapshot.data?"Weight Tracker":"Kilo Takipçisi",style:themeData.textTheme.bodyText2),
                          subtitle:Text(asyncSnapshot.data?"You can check your weight evolution with this":"Bununla kilo evrimini inceleyebilirsin",style:themeData.textTheme.bodyText1),
                          trailing:Icon(Icons.fitness_center_rounded,color:COLOR_WHITE,size:27),
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpace(size.height/30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:15),
                    child: InkWell(
                      onTap:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => OneRMTracker()));
                      },
                      child: Card(
                        color:COLOR_SEARCH_BLACK,
                        child:ListTile(
                          title:Text(asyncSnapshot.data?"1RM Tracker":"1RM Takipçisi",style:themeData.textTheme.bodyText2),
                          subtitle:Text(asyncSnapshot.data?"You can see your 1RM evolution with this":"Bununla 1 tekrar max evrimini inceleyebilirsin",style:themeData.textTheme.bodyText1),
                          trailing:Icon(Icons.fitness_center_rounded,color:COLOR_WHITE,size:27),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            else{
              return SizedBox();
            }
              },
            ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: COLOR_ORANGE,
          child: Icon(Icons.fitness_center_rounded),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => WorkoutPage()));
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color:COLOR_SEARCH_BLACK,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Text("1RM",style:themeData.textTheme.headline6), onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => OneRMTracker()));
              },),
              IconButton(icon: Icon(Icons.fastfood,color:COLOR_WHITE), onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => WeightTracker()));
              },),
            ],
          ),
        ),
        ),
      );
  }
}
