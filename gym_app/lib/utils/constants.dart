import 'package:flutter/material.dart';

const BACKGROUND_WHITE = Color.fromRGBO(240, 233, 233,1);
const COLOR_WHITE = Color.fromRGBO(223, 223, 232,1);
const COLOR_BLACK = Colors.black;
const COLOR_ORANGE = Color.fromRGBO(222, 83, 18,1);
const COLOR_SEARCH_BLACK = Color.fromRGBO(38, 36, 36,1);
const COLOR_GRAY = Color.fromRGBO(130, 129, 126,1);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
  headline1:TextStyle(
      color:COLOR_BLACK,fontWeight:FontWeight.w700, fontSize:28
  ),
  headline2:TextStyle(
      color:COLOR_WHITE,fontWeight:FontWeight.w800, fontSize:24
  ),
  headline3:TextStyle(
    color:COLOR_ORANGE,fontWeight:FontWeight.w800, fontSize:32,
  ),
  headline4:TextStyle(
    color:COLOR_WHITE,fontWeight:FontWeight.w600,fontSize:16,
  ),
  headline5:TextStyle(
    color:COLOR_ORANGE,fontWeight:FontWeight.w600,fontSize:16,
  ),
  headline6:TextStyle(
    color:COLOR_WHITE,fontWeight:FontWeight.w500, fontSize:15,
  ),
  bodyText1:TextStyle(
    color:COLOR_GRAY,fontSize:12,fontWeight:FontWeight.w500,
  ),
  bodyText2:TextStyle(
      color:COLOR_WHITE,fontSize:20,fontWeight:FontWeight.w500,
  ),
  subtitle1:TextStyle(
    color:COLOR_WHITE,fontWeight:FontWeight.w600,fontSize:24,
  ),
  subtitle2: TextStyle(
    color:COLOR_ORANGE,fontWeight:FontWeight.w500,fontSize:19,
  ),
);

const TextTheme TEXT_THEME_SMALL = TextTheme(
  headline1:TextStyle(
      color:COLOR_BLACK,fontWeight:FontWeight.w700, fontSize:22
  ),
  headline2:TextStyle(
      color:COLOR_BLACK,fontWeight:FontWeight.w700, fontSize:18
  ),
  headline3:TextStyle(
      color:COLOR_BLACK,fontWeight:FontWeight.w700, fontSize:16
  ),
  bodyText1:TextStyle(
      color:COLOR_BLACK,fontSize:10,fontWeight:FontWeight.w500,height:1.5
  ),
  subtitle1:TextStyle(
      color:COLOR_BLACK,fontSize:8,fontWeight:FontWeight.w400
  ),
);