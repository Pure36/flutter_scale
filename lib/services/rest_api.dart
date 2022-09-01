// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter_scale/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  // API URL
  String baseURLAPI = 'https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/api/';

  // กำหนด header ของ api
  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };

  // สร้างฟังก์ชัน Login API
  loginAPI(data) async {
    return await http.post(
      Uri.parse(baseURLAPI+'login'),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  // สร้างฟังก์ชัน Register API
  registerAPI(data) async {
    return await http.post(
      Uri.parse(baseURLAPI+'register'),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  // สร้างฟังก์ชันในการอ่านข่าวทั้งหมด
  Future<List<NewsModel>?> getAllNews() async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'news'),
      headers: _setHeaders()
    );
    if(response.body != null) {
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }


}