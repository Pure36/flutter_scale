import 'dart:convert';

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

}