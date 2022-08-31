// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              accountName: Text('Samit Koyom'), 
              accountEmail: Text('samit@email.com'),
              currentAccountPicture: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.green,
                // backgroundImage: NetworkImage('https://www.itgenius.co.th/backend/assets/images/user_avatar/2qxyqud0ha7wj4nf6p26xxy0heoyyxkz.jpg'),
               child: Image.asset('assets/images/smk.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('เกี่ยวกับเรา'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('ข้อมูลการใช้งาน'),
              onTap: () { 
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('ติดต่อทีมงาน'),
              onTap: () { 
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('ออกจากระบบ'),
              onTap: () { },
            )
          ],
        ),
      ),

    );
  }
}