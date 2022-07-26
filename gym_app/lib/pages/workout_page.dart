import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_app/utils/constants.dart';
import 'package:gym_app/utils/widget_functions.dart';

class WorkoutCardPage extends StatelessWidget {
  WorkoutCardPage({Key key,
  @required this.day, @required this.name, @required this.days, @required this.workouts, @required this.workoutNames
  }) : super(key: key);

  List days;
  List workouts;
  String name;
  String day;
  List workoutNames;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child:Scaffold(
        backgroundColor: COLOR_BLACK,
        body:Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child:IconButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  icon:Icon(Icons.arrow_back,color:COLOR_WHITE,size:29),
                ),
            ),
            addVerticalSpace(size.height/15),
            Text(name,style:themeData.textTheme.headline3),
            addVerticalSpace(size.height/15),
            Flexible(
                child:CarouselSlider.builder(
                  itemCount: days.length,
                  itemBuilder: (BuildContext context, int index,int itemIndex){
                    return Container(
                      width:size.width,
                      color:COLOR_SEARCH_BLACK,
                      child:Column(
                        children: [
                          addVerticalSpace(size.height/100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(alignment:Alignment.topCenter,child:Text(days[index] + " -",style:themeData.textTheme.subtitle1)),
                              addHorizontalSpace(size.width/55),
                              Align(alignment:Alignment.topCenter,child:Text(workoutNames[index],style:themeData.textTheme.subtitle1)),
                            ],
                          ),
                          addVerticalSpace(size.height/40),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:7.0),
                            child: Align(alignment:Alignment.topLeft,child: Text(workouts[index])),
                          )
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 1.0,
                    initialPage: 0,
                ),
                ),

            ),
          ],
        ),
      ),
    );
  }
}
