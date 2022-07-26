import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

import '../utils/constants.dart';
import 'login_page.dart';
import 'splash_page.dart';

void main(){
  double width = window.physicalSize.width;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title:"Movie Application",
    theme:ThemeData(primaryColor:COLOR_WHITE,textTheme:width < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,fontFamily:"Nunito"),
      home:Splash(),
  ));
}