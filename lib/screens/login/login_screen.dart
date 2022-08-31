// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปรไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _username, _password;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username"
                    ),
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'ต้องป้อนชื่อผู้ใช้';
                      }else{
                        return null;
                      } 
                    },
                    onSaved: (val){
                      _username = val.toString().trim();
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'ต้องป้อนรหัสผ่าน';
                      }else{
                        return null;
                      } 
                    },
                    onSaved: (val){
                      _password = val.toString().trim();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigator.pushReplacementNamed(context, '/dashboard');
                        // เช็คว่าป้อนค่าในฟอร์มครบหรือไม่
                        if(formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          print(_username);
                          print(_password);

                        }
                      }, 
                      child: Text("LOGIN")
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}