// ignore_for_file: prefer_conditional_assignment, body_might_complete_normally_nullable, prefer_const_constructors, unused_local_variable, unnecessary_new, unused_element

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Utility {

  static Utility? utility;

  static Utility? getInstance() {
    if(utility == null){
      utility = Utility();
    }

    return utility;
  }

  // สร้างฟังก์ชันสำหรับเช็คการเชื่อมต่อ Network
  Future<String> checkNetwork() async {

     // เช็คว่ามีการเชื่อมต่อ Internet ไว้หรือไม่
    var checkNetwork = await Connectivity().checkConnectivity();

    if(checkNetwork == ConnectivityResult.mobile) {
      return "mobile";
    }else if(checkNetwork == ConnectivityResult.wifi) {
      return "wifi";
    }else if(checkNetwork == ConnectivityResult.ethernet){
      return "ethernet";
    }else if(checkNetwork == ConnectivityResult.none){
      return "";
    }
    
    return "";

  }

  // สร้างฟังก์ชันสำหรับแสดง Alert
  showAlertDialog(BuildContext context, String alertTitle,String alertMessage){

    Widget okButton = TextButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text('OK')
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(alertMessage)
          ],
        ),
      ),
      actions: [okButton],
    );

    // Show Dialog
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return alert;
      }
    );

  }

}