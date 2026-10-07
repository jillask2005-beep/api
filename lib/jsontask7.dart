import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task8 extends StatefulWidget {
  const task8({super.key});

  @override
  State<task8> createState() => _task8State();
}

class _task8State extends State<task8> {
  List listmap=[];
  Future<List<classroom1>> getData() async{
    try{
      var apiresponse=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      print(apiresponse);
      print(apiresponse.statusCode);
      if(apiresponse.statusCode==200){
        listmap=jsonDecode(apiresponse.body);
        return listmap.map((first)=>classroom1.fromJson(first)).toList();
      }else{
        throw Exception("no data found");
      }
    }catch (e){
      throw e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text("error:${snapshot.error}");
        }else if (snapshot.hasData){
          return ListView.builder(itemCount: listmap.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.green,
              child: Column(
                children: [
                  Text(listmap[index]["albumId"].toString()),
                  Text(listmap[index]["id"].toString()),
                  Text(listmap[index]["title"].toString()),
                  Text(listmap[index]["url"].toString()),
                  Text(listmap[index]["thumbnailUrl"].toString())
                ],
              ),
            );
          },);
        }else{
          return Text("no found data");
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

