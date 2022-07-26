import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../utils/constants.dart';
import '../utils/widget_functions.dart';
import '../widgets/textField_orange.dart';

class OneRMPage extends StatefulWidget {
  const OneRMPage({Key key}) : super(key: key);

  @override
  State<OneRMPage> createState() => _OneRMPageState();
}

class _OneRMPageState extends State<OneRMPage> {
  TextEditingController onermController = TextEditingController();
  TextEditingController repController = TextEditingController();
  double weight;
  double oneRm;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: COLOR_BLACK,
        body: FutureBuilder<bool>(
            future: myFunc(),
            builder: (
              BuildContext context,
              AsyncSnapshot<bool> asyncSnapshot,
            ) {
              if (asyncSnapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: COLOR_WHITE, size: 29),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Flexible(
                            child: Text(asyncSnapshot.data
                                ? "1RM Calculator"
                                : "1RM Hesaplayıcı"))
                      ],
                    ),
                    addVerticalSpace(size.height / 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Center(
                                child: Text(
                                    asyncSnapshot.data
                                        ? "Calculate Your 1RM Buddy"
                                        : "1RM'ini Hesapla Dostum",
                                    style: TextStyle(
                                        color: COLOR_ORANGE,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 27)))),
                      ],
                    ),
                    addVerticalSpace(size.height / 13),
                    TextFieldOrange(
                        controller: onermController,
                        string: asyncSnapshot.data ? "Weight" : "Kilo"),
                    TextFieldOrange(
                        controller: repController,
                        string: asyncSnapshot.data
                            ? "Repetitions"
                            : "Tekrar Sayısı"),
                    addVerticalSpace(size.height / 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            oneRm = (100 * double.parse(onermController.text)) /
                                (101.3 -
                                    (2.67123 *
                                        double.parse(repController.text)));
                          });
                        },
                        child: Text(
                            asyncSnapshot.data
                                ? "Submit To Calculate"
                                : "Hesaplamak İçin Tıkla",
                            style: themeData.textTheme.headline4),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(COLOR_ORANGE),
                        ),
                      ),
                    ),
                    addVerticalSpace(size.height / 60),
                    Center(
                      child: oneRm != null
                          ? oneRm.toString().split(".")[0].length >= 3 ?Text(oneRm.toString()[0] +
                              oneRm.toString()[1] +
                              oneRm.toString()[2] +
                              oneRm.toString()[3] +
                              oneRm.toString()[4])
                            : Text(oneRm.toString()[0] + oneRm.toString()[1] + oneRm.toString()[2] + oneRm.toString()[3])
                          : Text(""),

                      ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
      ),
    );
  }
}
