import 'dart:async';
import 'package:TaskManager/MyNavigator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 150.0)),
              Image.asset(
                "assets/img/logo2.png",
                scale: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 120)),
                  CircularProgressIndicator(
                    //backgroundColor: Color.fromRGBO(142,188,35,1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Text(
                    "wait for a while",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 11,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
