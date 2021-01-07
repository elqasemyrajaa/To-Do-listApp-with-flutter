import 'package:flutter/material.dart';

import 'main.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.push(context,MaterialPageRoute(
     builder: (context) => MyHomePage()));
  }
}