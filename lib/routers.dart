import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawermenu/about_screen.dart';
import 'package:flutter_scale/screens/drawermenu/contact_screen.dart';
import 'package:flutter_scale/screens/drawermenu/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/register/register_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

// สร้างตัวแปรแบบ Map (Key-Value)
Map<String, WidgetBuilder> routes = {
  "/welcome":(BuildContext context) => WelcomeScreen(),
  "/login":(BuildContext context) => LoginScreen(),
  "/register":(BuildContext context) => RegisterScreen(),
  "/dashboard":(BuildContext context) => DashboardScreen(),
  "/about":(BuildContext context) => AboutScreen(),
  "/info":(BuildContext context) => InfoScreen(),
  "/contact":(BuildContext context) => ContactScreen(),
};