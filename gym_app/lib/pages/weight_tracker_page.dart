import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import '../widgets/textField_orange.dart';
import '../pages/home_page.dart';

class WeightTracker extends StatefulWidget {
  String currentWeight;
  String targetWeight;

  WeightTracker({Key key,
  this.currentWeight,this.targetWeight
  }) : super(key: key);

  @override
  State<WeightTracker> createState() => _WeightTrackerState();
}

class _WeightTrackerState extends State<WeightTracker> {
  TextEditingController weightController = TextEditingController();
  List<double> weightList = [double.parse(currentWeight2)];

  Future<void> savePreferences(String value)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("currentWeight",value);
  }

  Future<void> listPreferences()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList("weightList",weightList.map((i) => i.toString()).toList());
  }

  Future<void> getListPreferences()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_prefs.getStringList("weightList") != null){
      setState((){
        weightList = _prefs.getStringList("weightList").map((i) => double.parse(i)).toList();
        if(!weightList.contains(double.parse(currentWeight2))){
          weightList.add(double.parse(currentWeight2));
        }
      });
    }
    else{
      if(weightList == []){
        setState((){
          weightList.add(double.parse(currentWeight2));
        });
      }
      weightList = weightList;
    }
  }

  @override
  void initState(){
    super.initState();
    getListPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    int absValue = (int.parse(currentWeight2)-int.parse(targetWeight2)).abs();

    return SafeArea(
      child:Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:COLOR_BLACK,
        body:FutureBuilder(
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
                        ? "Weight Tracker For Better You"
                        : "Daha İyi Sen İçin Kilo Takipçisi"))
                  ],
                ),
                addVerticalSpace(size.width / 8),
                Center(
                    child: Text(asyncSnapshot.data
                        ? "Weight Tracker For Better You"
                        : "Daha İyi Sen İçin Kilo Takipçisi",
                        style: TextStyle(
                            color: COLOR_ORANGE,
                            fontWeight: FontWeight.w600,
                            fontSize: 27))),
                addVerticalSpace(size.width / 8),
                PhysicalModel(
                  color:COLOR_SEARCH_BLACK,
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    color: COLOR_SEARCH_BLACK,
                    child: Container(
                      width: size.width / 1.2,
                      height: size.height / 3.5,
                      child: Row(
                        children: [
                          addHorizontalSpace(size.width/90),
                          PhysicalModel(
                            color: COLOR_ORANGE,
                            borderRadius:BorderRadius.circular(20),
                            child:Container(
                              width:size.width/3.3,
                              height:size.height/3.6,
                                child: Image.asset(
                                  "assets/images/Zyzz.png"
                              ),
                            ),
                          ),
                          addHorizontalSpace(size.width/30),
                          PhysicalModel(
                            color:COLOR_ORANGE,
                            borderRadius:BorderRadius.circular(20),
                            child: Container(
                              width:size.width/2.5,
                              height:size.height/3.5/1.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(asyncSnapshot.data
                                      ? "Target : $targetWeight2"
                                      : "Hedef Kilon : $targetWeight2",style:TextStyle(color:COLOR_BLACK,fontWeight:FontWeight.w600)),
                                  addVerticalSpace(size.height / 3.5 / 8),
                                  Text(asyncSnapshot.data
                                      ? "Gain Or Lose : $absValue"
                                      : "Al Ya Da Ver : $absValue",
                                      style: TextStyle(color: COLOR_BLACK,
                                        fontWeight: FontWeight.w600,fontSize:18)),
                                  addVerticalSpace(size.height / 3.5 / 8),
                                  Text(asyncSnapshot.data
                                      ? "Current : $currentWeight2"
                                      : "Kilon : $currentWeight2",style:TextStyle(color:COLOR_BLACK,fontWeight:FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(size.width / 16),
                TextFieldOrange(controller: weightController,
                    string: asyncSnapshot.data
                        ? "What is your current weight :"
                        : "Şuanki kilon kaç :"),
                Center(
                  child: ElevatedButton(

                    onPressed: () {
                      setState(() {
                        currentWeight2 = weightController.text;
                        weightList.insert(weightList.length - weightList.length,
                            double.parse(currentWeight2));
                        listPreferences();
                        savePreferences(currentWeight2);
                      });
                    },
                    child: Text(asyncSnapshot.data?"Submit To Add":"Eklemek İçin Tıkla",
                        style: themeData.textTheme.headline4),
                    style: ButtonStyle(
            shape:MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(12),
            ),
            ),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(COLOR_ORANGE),
                    ),
                  ),
                ),
                addVerticalSpace(size.height/40),
                Center(
                  child: Text(asyncSnapshot.data ? "Weight List" : "Kilo Listesi",style:TextStyle(color:COLOR_ORANGE,fontWeight:FontWeight.w600,fontSize:23)),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: weightList==[] || weightList == null?1:weightList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: COLOR_SEARCH_BLACK,
                        child: ListTile(
                          title: Text(weightList==[] || weightList == null?currentWeight2:weightList[index].toString()),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  weightList.remove(weightList[index]);
                                  listPreferences();
                                  savePreferences(currentWeight2);
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.red)),
                        ),
                      );
                    },
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
