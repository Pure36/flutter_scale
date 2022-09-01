// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_scale/routers.dart';
import 'package:flutter_scale/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userStep;
var initURL;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep');

  if(userStep == 1){
    initURL = '/dashboard';
  }else{
    initURL = '/welcome';
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }

}