// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                    SizedBox(height: 30,),
                    SizedBox(
                      width: 250,
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
                      width: 250,
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
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () async {
                            // เช็คว่าป้อนค่าในฟอร์มครบหรือไม่
                            if(formKey.currentState!.validate()) {
                              formKey.currentState!.save();
      
                              // print(_username);
                              // print(_password);

                              // เช็คว่ามีการเชื่อมต่อ Internet ไว้หรือไม่
                              // print(await Utility.getInstance()!.checkNetwork());

                              if(await Utility.getInstance()!.checkNetwork() == ""){
                                
                                Utility.getInstance()!.showAlertDialog(
                                  context, 
                                  "มีข้อผิดพลาด", 
                                  "อุปกรณ์ของท่านยังไม่ได้เชื่อมต่อ Internet"
                                );
                                
                              } else {

                                // เรียกใช้งาน LoginAPI
                                var response = await CallAPI().loginAPI(
                                  {
                                    "username": _username,
                                    "password": _password
                                  }
                                );
        
                                var body = json.decode(response.body);
        
                                if(body['status'] == 'success'){

                                  // สร้าง Object แบบ SharedPreferences
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                  // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                                  sharedPreferences.setInt('userStep', 1);
                                  sharedPreferences.setString('userID', body['data']['id']);
                                  sharedPreferences.setString('userName', body['data']['username']);
                                  sharedPreferences.setString('fullName', body['data']['fullname']);
                                  sharedPreferences.setString('imgProfile', body['data']['img_profile']);
                                  sharedPreferences.setString('userStatus', body['data']['status']);

                                  // ส่งไปหน้า Dashboard
                                  Navigator.pushReplacementNamed(context, '/dashboard');
                                }else{

                                  Utility.getInstance()!.showAlertDialog(
                                    context, 
                                    "มีข้อผิดพลาด", 
                                    "ข้อมูลเข้าระบบไม่ถูกต้อง"
                                  );
                                  
                                }
                              }
      
                            }
                          }, 
                          child: Text("LOGIN")
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/register');
                      }, 
                      child: Text("Not have account Register")
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