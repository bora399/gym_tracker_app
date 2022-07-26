import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';

class WorkoutWidget extends StatelessWidget {
  WorkoutWidget({this.name,this.page});

  String name;
  Widget page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        Navigator.push(context,MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        color:COLOR_SEARCH_BLACK,
        child:ListTile(
          title:Text(name),
          trailing:Icon(Icons.fitness_center_rounded,color:COLOR_WHITE,size:27),
        ),
      ),
    );;
  }
}
