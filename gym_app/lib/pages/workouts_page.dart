import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/pages/workout_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import '../widgets/workout_widget.dart';
import '../pages/home_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  bool workoutChoose = true;

  Future<void> saveBool(bool value)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("workoutChoose",value);
  }

  Future<void> getBool()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_prefs.getBool("workoutChoose") != null){
      setState((){
        workoutChoose = _prefs.getBool("workoutChoose");
      });
    }
    else{
      workoutChoose = workoutChoose;
    }
  }

  @override
  void initState(){
    super.initState();
    getBool();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
        body: FutureBuilder(
          future:myFunc(),
          builder:(BuildContext context, AsyncSnapshot asyncSnapshot,) {
            if(asyncSnapshot.hasData){
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          Icons.arrow_back, color: COLOR_WHITE, size: 29),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Flexible(child: Text(asyncSnapshot.data
                        ? "Elite Workout Plans For You"
                        : "Senin İçin Elit Antrenman Programları"))
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          workoutChoose = true;
                          saveBool(workoutChoose);
                        });
                      },
                      child: Container(
                        width: size.width / 2,
                        child: Card(
                            color: workoutChoose == true
                                ? COLOR_ORANGE
                                : COLOR_SEARCH_BLACK,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  asyncSnapshot.data
                                      ? "Celebrity Workouts"
                                      : "Ünlü Antrenmanları", style: TextStyle(
                                    color: COLOR_WHITE,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          workoutChoose = false;
                          saveBool(workoutChoose);
                        });
                      },
                      child: Container(
                        width: size.width / 2,
                        child: Card(
                            color: workoutChoose == false
                                ? COLOR_ORANGE
                                : COLOR_SEARCH_BLACK,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  asyncSnapshot.data
                                      ? "Best Workouts For You"
                                      : "Senin İçin Antrenmanlar",
                                  style: TextStyle(color: COLOR_WHITE,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(size.height / 30),
                workoutChoose == true ? Flexible(
                  child: Column(
                    children: [
                      WorkoutWidget(name: asyncSnapshot.data
                          ? "ZYZZ Workout"
                          : "ZYZZ Antrenmanı",
                          page: WorkoutCardPage(day: "5",
                              name: "ZYZZ Workout Plan",
                              days: ["Monday", "Tuesday"],
                              workoutNames: ["Chest Day", "Back Day"],
                              workouts: ["Bench Press", "Row"])),
                    ],
                  ),
                )
                    : Flexible(
                  child: Column(
                    children: [
                      WorkoutWidget(name: asyncSnapshot.data
                          ? "Normal Workout"
                          : "Normal Antrenman", page: HomePage()),
                    ],
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
      ),
    );
  }
}
