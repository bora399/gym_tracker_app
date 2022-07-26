import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_app/utils/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/widget_functions.dart';
import '../widgets/textField_orange.dart';
import '../pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  int currentWeight = 60;
  int targetWeight = 60;

  void readySharedPreferences()async{
    var _pref = await SharedPreferences.getInstance();
    setState((){
      saveData();
    });
  }

  void saveData()async{
    var _pref = await SharedPreferences.getInstance();
    _pref.setBool("seen",false);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_BLACK,
        body:Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  addVerticalSpace(size.height/7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("Fit & Better",style:themeData.textTheme.headline3)),
                      addHorizontalSpace(size.width/80),
                      Center(child: Icon(Icons.fitness_center_rounded,color:COLOR_ORANGE,size:28))
                    ],
                  ),
                  addVerticalSpace(size.height/20),
                  TextFieldOrange(controller:nameController,string:"Your Name"),
                  addVerticalSpace(size.height/20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:EdgeInsets.symmetric(horizontal:8.0),
                            child:Text("Current Weight",style:themeData.textTheme.headline4),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width/15,vertical:8.0),
                            child: Card(
                              color:COLOR_SEARCH_BLACK,
                              child: NumberPicker(
                                value:currentWeight,
                                textStyle:themeData.textTheme.headline4,
                                selectedTextStyle: themeData.textTheme.headline5,
                                minValue:0,
                                maxValue:300,
                                step:10,
                                onChanged: (value) {
                                  setState(() {
                                    currentWeight = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding:EdgeInsets.symmetric(horizontal:8.0),
                              child:Text(currentWeight.toString(),style:themeData.textTheme.headline4)
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:EdgeInsets.symmetric(horizontal:8.0),
                            child:Text("Target Weight",style:themeData.textTheme.headline4),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.width/15,vertical:8.0),
                            child: Card(
                              color:COLOR_SEARCH_BLACK,
                              child: NumberPicker(
                                value:targetWeight,
                                textStyle:themeData.textTheme.headline4,
                                selectedTextStyle: themeData.textTheme.headline5,
                                minValue:0,
                                maxValue:300,
                                step:10,
                                onChanged: (value) {
                                  setState(() {
                                    targetWeight = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding:EdgeInsets.symmetric(horizontal:8.0),
                              child:Text(targetWeight.toString(),style:themeData.textTheme.headline4)
                          ),
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(size.height/25),
                  Center(
                    child:ElevatedButton(
                      onPressed:(){
                        if(nameController.text!="" && nameController.text.length<25 && currentWeight!=targetWeight){
                          readySharedPreferences();
                          Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(currentWeight: currentWeight.toString(),targetWeight: targetWeight.toString(),name:nameController.text)));
                        }
                      },
                      child:Text("Submit To Be Soldier Of Zyzz",style:themeData.textTheme.headline4),
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(COLOR_ORANGE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
