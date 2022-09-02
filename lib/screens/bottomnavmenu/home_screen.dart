// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/services/rest_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() { });
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'ข่าวประกาศล่าสุด',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 210,
              child: FutureBuilder(
                future: CallAPI().getLastNews(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError){
                    // ถ้าโหลดข้อมูลไมไ่ด้ หรือมีข้อผิดพลาด
                    return Center(
                      child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                    );
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    // ถ้าโหลดข้อมูลสำเร็จ
                    List<NewsModel> news = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal, // ListView แนวนอน
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        // Load Model
                        NewsModel newsModel = news[index];
                        // ส่วนการแสดงผลหน้าตา ListView
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                context, 
                                '/newsdetail',
                                arguments: { 'id': newsModel.id }
                              );
                            },
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 125.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(newsModel.imageurl),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter
                                        )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            newsModel.topic,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            newsModel.detail,
                                            style: TextStyle(fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  } else {
                    // ระหว่างที่กำลังโหลดข้อมูล สามารถใส่ loading...
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'ข่าวประกาศทั้งหมด',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              child: FutureBuilder(
                future: CallAPI().getAllNews(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError){
                    // ถ้าโหลดข้อมูลไมไ่ด้ หรือมีข้อผิดพลาด
                    return Center(
                      child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                    );
                  } else if(snapshot.connectionState == ConnectionState.done) {
                    // ถ้าโหลดข้อมูลสำเร็จ
                    List<NewsModel> news = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        
                        // Load Model
                        NewsModel newsModel = news[index];
    
                        // แสดงผลใน ListTile
                        return ListTile(
                          leading: Icon(Icons.pages),
                          title: Text(newsModel.topic, overflow: TextOverflow.ellipsis,),
                          subtitle: Text(newsModel.detail, overflow: TextOverflow.ellipsis,),
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              '/newsdetail',
                              arguments: { 'id': newsModel.id }
                            );
                          },
                        );
    
                      }
                    );
                  } else {
                    // ระหว่างที่กำลังโหลดข้อมูล สามารถใส่ loading...
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}