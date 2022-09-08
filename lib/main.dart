// import 'dart:ffi';
// import 'dart:html';

// import 'dart:html';
//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/firstpage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: AnimatedSplashScreen(
          splash: Wrap(
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.sunny,
                  size: 120,
                  color: Colors.yellow[400],
                ),
              ),
              Center(
                child: Text(
                  'Welcome to \n Temperature Converter!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          duration: 3000,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.purple,

          // Center(

          //     child: Container(
          //       child: Text(
          //         'Welcome to \n Temperature Converter!',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          nextScreen: TempApp(),
        ));
  }
}

class TempApp extends StatefulWidget {
  @override
  TempState createState() => TempState();
}

class TempState extends State<TempApp> {
  late double input;
  late double output;
  late bool isF;

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    isF = true;
  }

  String outputImageFile() {
    if (isF == true) {
      if (output <= 0) {
        return 'assets/cold.png';
      } else {
        return 'assets/hot.png';
      }
    } else {
      if (output <= 32) {
        return 'assets/cold.png';
      } else {
        return 'assets/hot.png';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text("Temperature Converter"));

    TextField inputField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch (e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText: "${isF == true ? "Fahrenheit" : " Calsius"}",
      ),
      textAlign: TextAlign.center,
    );

    Container tempSwitch = Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Text("F"),
          Radio<bool>(
              groupValue: isF,
              value: true,
              onChanged: (newVal) {
                setState(() {
                  isF = newVal!;
                });
              }),
          Text("C"),
          Radio<bool>(
              groupValue: isF,
              value: false,
              onChanged: (newVal) {
                setState(() {
                  isF = newVal!;
                });
              }),
        ],
      ),
    );

    SizedBox outputTitle = SizedBox(
      width: double.infinity,
      child: Container(
        child: Text(
          "${isF == true ? "Celsius" : "Fahrenheit "}",
          style: TextStyle(fontSize: 16.0, color: Colors.grey[600], height: 4),
          textAlign: TextAlign.left,
        ),
      ),
    );

    Text outputField = Text(
      "$output",
      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, height: 2),
    );

    Container outputImage = Container(
      padding: EdgeInsets.all(20.0),
      child: Image.asset(
        "${outputImageFile()}",
        width: 100,
        height: 100,
      ),
    );

    Container calcBtn = Container(
      child: ElevatedButton(
        child: Text("Calculate"),
        onPressed: () {
          setState(() {
            setState(() {
              isF == true
                  ? output = (input - 32) * (5 / 9)
                  : output = (input * 9 / 5) + 32;
            });
          });
        },
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              inputField,
              calcBtn,
              tempSwitch,
              outputTitle,
              outputField,
              outputImage,
            ],
          ),
        ),
      ),
    );
  }
}
