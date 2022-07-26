import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/widgets/textField_orange.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import '../pages/home_page.dart';

class OneRMTracker extends StatefulWidget {
  const OneRMTracker({Key key}) : super(key: key);

  @override
  State<OneRMTracker> createState() => _OneRMTrackerState();
}

class _OneRMTrackerState extends State<OneRMTracker> {
  List<double> oneRMList = [0.0];
  List<String> stringsList;
  TextEditingController onermController = TextEditingController();

  Future<void> readySharedPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    stringsList = await _prefs.getStringList("onermList");
    setState((){
      saveData();
    });
  }

  Future<void> saveData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(stringsList != null){
      setState((){
        oneRMList = stringsList.map((i) => double.parse(i)).toList();
      });
    }
    _prefs.setStringList("onermList", stringsList);
  }

  Future<void> saveData2() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList("onermList", oneRMList.map((i) => i.toString()).toList());
  }

  @override
  void initState() {
    super.initState();
    readySharedPreferences();
  }

  double minList(List list) {
    list.sort();
    return list[0];
  }

  double maxList(List list) {
    list.sort((a, b) => b.compareTo(a));
    return list[0];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_BLACK,
        body: FutureBuilder(
          future:myFunc(),
          builder:(BuildContext context, AsyncSnapshot<bool> asyncSnapshot) {
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
                        ? "1RM Tracker Page"
                        : "1RM Takipi Sayfası")),
                  ],
                ),
                addVerticalSpace(size.width / 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                            child: Center(
                                child: Text(asyncSnapshot.data
                                    ? "1RM Tracker For Better You"
                                    : "Daha İyi Sen İçin 1RM Takipçisi",
                                    style: TextStyle(
                                        color: COLOR_ORANGE,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 27))),
                          ),
                  ],
                ),
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
                              color:COLOR_ORANGE,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width:size.width/3.3,
                                height:size.height/3.5,
                                child:Column(
                                  children: [
                                    addVerticalSpace(size.height/25),
                                    Image.asset("assets/images/Zyzz.png"),
                                  ],
                                ),
                              ),
                            ),
                            addHorizontalSpace(size.width/17),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                  width:size.width/2.7,
                                  height:size.height/25,
                                  color:COLOR_ORANGE,
                                  child:Center(
                                    child: Text(asyncSnapshot.data
                                        ? "Your 1RM Best"
                                        : "1RM'de Max",
                                        style: TextStyle(color:COLOR_BLACK,fontWeight:FontWeight.w600,fontSize:18)),
                                  )),
                                ),
                                addVerticalSpace(size.height / 3.5 / 35),
                                ClipRRect(
                                  borderRadius:BorderRadius.circular(8),
                                  child: Container(
                                    color:COLOR_ORANGE,
                                    width:size.width/3,
                                    height:size.height/20,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: oneRMList != null
                                            ? Text(maxList(oneRMList).toString(),
                                            style: TextStyle(color:COLOR_BLACK,fontWeight:FontWeight.w800, fontSize:28,))
                                            : Text("")),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
                addVerticalSpace(size.width / 15),
                TextFieldOrange(
                      controller: onermController,
                      string: asyncSnapshot.data ? "Write Your 1RM" : "1RM'ini Yaz"),
            Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            oneRMList.add(double.parse(onermController.text));
                            saveData2();
                          });
                        },
                        child: Text(asyncSnapshot.data
                            ? "Submit To Calculate"
                            : "Hesaplamak İçin Tıkla",
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
                addVerticalSpace(size.width / 20),
                Center(
                  child: Text(asyncSnapshot.data ? "1RM List" : "1RM Listesi",style:TextStyle(color:COLOR_ORANGE,fontWeight:FontWeight.w600,fontSize:23)),
                ),
                addVerticalSpace(size.width / 100),
                Flexible(
                  child: ListView.builder(
                      itemCount: oneRMList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: COLOR_SEARCH_BLACK,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(oneRMList[index].toString() == "0.0"
                                    ? ""
                                    : oneRMList[index].toString()),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (oneRMList.length == 1) {
                                        null;
                                      }
                                      else {
                                        oneRMList.remove(oneRMList[index]);
                                        saveData2();
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 27),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
