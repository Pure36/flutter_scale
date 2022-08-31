// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
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
                        // เช็คว่าป้อนค่าในฟอร์มครบหรือไม่
                        if(formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          // print(_username);
                          // print(_password);
                          // เรียกใช้งาน LoginAPI
                          var response = await CallAPI().loginAPI(
                            {
                              "username": _username,
                              "password": _password
                            }
                          );

                          var body = json.decode(response.body);

                          if(body['status'] == 'success'){
                            Navigator.pushReplacementNamed(context, '/dashboard');
                          }else{
                            AlertDialog alert = AlertDialog(
                              title: Text("มีข้อผิดพลาด"),
                              content: Text("ข้อมูลเข้าระบบไม่ถูกต้อง"),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("OK")
                                )
                              ],
                            );

                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return alert;
                              }
                            );
                          }

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