// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้าง Sharedpreference Object
  late SharedPreferences sharedPreferences;

  // สร้างตัวแปรเก็บ fullname, username, avatar
  String? _fullname, _username, _avatar, _userstatus;

  // สร้างตัวแปรไว้เก็บลำดับที่ของ list
  int _currentIndex = 0;

  // สร้างตัวแปรไว้เก็บ title
  String _title = 'Dashboard';

  // สร้างตัวแปรแบบ List เก็บหน้า Screen
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // สร้างฟังก์ชันสำหรับการเปลี่ยน tab
  void onTabChange(int index){
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: _title = "Dashboard"; break;
        case 1: _title = "Report"; break;
        case 2: _title = "Notification"; break;
        case 3: _title = "Setting"; break;
        case 4: _title = "Profile"; break;
      }
    });
  }

  // สร้างฟังก์ชันในการอ่านข้อมูล User
  readUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _fullname = sharedPreferences.getString("fullName");
      _username = sharedPreferences.getString("userName");
      _avatar = sharedPreferences.getString("imgProfile");
      _userstatus = sharedPreferences.getString("userStatus");
    });
  }

  // เรียกใช้งานฟังก์ชัน initial
  @override
  void initState() {
    super.initState();
    readUserProfile();
  }

  // สร้างฟังก์ชันสำหรับการ Logout
  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // เคลียร์ค่า SharedPreferences
    sharedPreferences.clear();
    // ส่งไปหน้า Login
    Navigator.pushReplacementNamed(context, '/login');
  }

  // ฟังก์ชันสำหรับเช็คการกดปุ่ม back
  Future<bool> _onWillPop() async {
    return (
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('Yes'),
            ),
          ],
        ),
      )
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: _children[_currentIndex],
        
        // Menu Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabChange,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'HOME'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              label: 'REPORT'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'NOTIFICATION'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'SETTING'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'PROFILE'
            ),
          ]
        ),
        
        // Menu Drawer
        drawer: Drawer(
          // backgroundColor: Colors.teal,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_fullname ?? "..."), 
                accountEmail: Text(_username ?? "..."),
                currentAccountPicture: _avatar != null ? 
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.green,
                  backgroundImage: NetworkImage('https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/images/profile/'+ _avatar!),
                //  child: Image.asset('assets/images/smk.jpg'),
                ) : CircularProgressIndicator(),
              ),
    
              _userstatus == "1" ?
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('เกี่ยวกับเรา'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
              ) : Container(),
    
              _userstatus == "1" ?
              ListTile(
                leading: Icon(Icons.book),
                title: Text('ข้อมูลการใช้งาน'),
                onTap: () { 
                  Navigator.pushNamed(context, '/info');
                },
              ) : Container(),
    
              _userstatus == "1" ?
              ListTile(
                leading: Icon(Icons.email),
                title: Text('ติดต่อทีมงาน'),
                onTap: () { 
                  Navigator.pushNamed(context, '/contact');
                },
              ) : Container(),
    
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('ออกจากระบบ'),
                onTap: () async { 
                  logOut();
                },
              )
            ],
          ),
        ),
      
      ),
    );
  }
}