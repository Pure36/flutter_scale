// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Text('Dashboard Screen'),
      ),
      
      // Menu Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
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
              onTap: () { },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('ข้อมูลการใช้งาน'),
              onTap: () { },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('ติดต่อทีมงาน'),
              onTap: () { },
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