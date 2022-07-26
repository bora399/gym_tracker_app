import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> saveLanguage(bool value)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("languageValue",value);
  }

  Future<void> getLanguage(bool value)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(_prefs.getBool("languageValue"));
  }

  Future<void> initFunc()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState((){
      if(_prefs.getBool("languageValue") != null){
        languageValue = _prefs.getBool("languageValue");
      }
      else{
        languageValue = languageValue;
      }
    });
  }

  @override
  void initState(){
    super.initState();
    initFunc();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_BLACK,
          body: WillPopScope(
            onWillPop:()async=>false,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed:(){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      icon:Icon(Icons.arrow_back,color:COLOR_WHITE,size:27),
                    ),
                    Center(child: Text(!languageValue?"Ayarlar Sayfası":"Settings Page",style:themeData.textTheme.headline2)),
                  ],
                ),
                addVerticalSpace(size.height/15),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal:size.width/80),
                  child:Card(
                    color:COLOR_SEARCH_BLACK,
                    child: SwitchListTile(
                      title:Text(languageValue?"English":"Türkçe"),
                      secondary: Icon(Icons.language,color:COLOR_WHITE),
                      value: languageValue,
                        onChanged: (bool state) {
                        setState(() {
                          languageValue = state;
                          saveLanguage(languageValue);
                        });
                        },
                ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
