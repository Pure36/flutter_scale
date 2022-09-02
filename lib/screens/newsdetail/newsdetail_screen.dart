// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/models/NewsDetailModel.dart';

class NewsDetailScreen extends StatefulWidget {
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  // เรียกใช้งาน Model
  NewsDetailModel? _dataNews;

  // สร้างฟังก์ชันอ่านรายละเอียดข่าว
  readNewsDetail(id) async {
    try {
      var response = await CallAPI().getNewsByID(id);
      setState(() {
        _dataNews = response!;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    // รับค่าจาก arguments
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    // print(arguments['id'].toString());

    // เรียกใช้งานฟังก์ชัน readNewsDetail
    readNewsDetail(arguments['id']).toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('${_dataNews?.topic ?? "..."}'),
      ),
      body: ListView (
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.imageurl ?? "..."),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${_dataNews?.topic ?? "..."}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${_dataNews?.detail ?? "..."}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Published: ${_dataNews?.createdAt ?? "..."}',
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}