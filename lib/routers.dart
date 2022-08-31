import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

// สร้างตัวแปรแบบ Map (Key-Value)
Map<String, WidgetBuilder> routes = {
  "/welcome":(BuildContext context) => WelcomeScreen(),
  "/login":(BuildContext context) => LoginScreen(),
  "/dashboard":(BuildContext context) => DashboardScreen(),
};