// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // สร้างตัวแปรไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับค่าจากฟอร์ม
  late String _fullname, _username, _password;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/mylogo.png', width: 150,),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Fullname"
                        ),
                        validator: (val) {
                          if(val!.isEmpty){
                            return 'ต้องป้อนชื่อ-สกุล';
                          }else{
                            return null;
                          } 
                        },
                        onSaved: (val){
                          _fullname = val.toString().trim();
                        },
                      ),
                    ),
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
                              
                              // เรียกใช้งาน RegisterAPI
                              var response = await CallAPI().registerAPI(
                                {
                                  "username": _username,
                                  "password": _password,
                                  "fullname": _fullname,
                                  "status": "1"
                                }
                              );
      
                              var body = json.decode(response.body);
      
                              if(body['status'] == 'success'){

                                  // สร้าง Object แบบ SharedPreferences
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                  // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                                  sharedPreferences.setInt('userStep', 1);
                                  sharedPreferences.setString('userName', _username);
                                  sharedPreferences.setString('fullName', _fullname);
                                  
                                  Navigator.pushReplacementNamed(context, '/dashboard');

                              }else{

                                Utility.getInstance()!.showAlertDialog(
                                  context, 
                                  "มีข้อผิดพลาด", 
                                  "ไม่สามารถลงทะเบียนได้"
                                );
                              }
      
                            }
                          }, 
                          child: Text("Register")
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/login');
                      }, 
                      child: Text("Already member ? Login")
                    )
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}