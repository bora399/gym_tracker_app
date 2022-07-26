import 'package:flutter/material.dart';

import '../utils/constants.dart';

class TextFieldOrange extends StatelessWidget {
  TextFieldOrange({this.controller,this.string});

  TextEditingController controller;
  String string;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color:COLOR_SEARCH_BLACK,
          child: TextField(
            controller:controller,
            cursorColor: COLOR_ORANGE,
            style: themeData.textTheme.headline4,
            decoration: InputDecoration(
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              hintText:string,
              hintStyle:themeData.textTheme.headline4,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: COLOR_SEARCH_BLACK),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: COLOR_ORANGE),
              ),

            ),
          ),
        ),
    );
  }
}
