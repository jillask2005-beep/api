import 'dart:convert';

import 'package:api/joson task2.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task3 extends StatefulWidget {
  const task3({super.key});

  @override
  State<task3> createState() => _task3State();
}

class _task3State extends State<task3> {
  List listusers=[];
  Future<List<classroom1>>getData() async{
    try{
      var apiresponse=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      print(apiresponse);
      print(apiresponse.statusCode);
      if(apiresponse.statusCode==200){
        listusers=jsonDecode(apiresponse.body);
        return listusers.map((first)=>classroom1.fromJson(first)).toList();
      }else {
        throw Exception("no found data");
      }
    }catch (e){
      print(e);
      throw e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
         return Text("error${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: listusers.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.lightBlue,
              child: Column(
                children: [
                  Text(listusers[index]["albumId"].toString()),
                  Text(listusers[index]["id"].toString()),
                  Text(listusers[index]["title"].toString()),
                  Text(listusers[index]["url"]),
                  Text(listusers[index]["thumbnailUrl"]),
                ],
              ),
            );
          },);
        }else{
          return Text("no data found");
        }
      }),
    );
  }
}

class classroom1 {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  classroom1({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  classroom1.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

