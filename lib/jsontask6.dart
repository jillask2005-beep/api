import 'dart:convert';

import 'package:api/jsontask4.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task7 extends StatefulWidget {
  const task7({super.key});

  @override
  State<task7> createState() => _task7State();
}

class _task7State extends State<task7> {
  List listuses=[];
  Future<List<classroom1>> getData() async{
    try{
      var apiresponse=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      print(apiresponse);
      print(apiresponse.statusCode);
      if(apiresponse.statusCode==200){
        listuses=jsonDecode(apiresponse.body);
        return listuses.map((first)=>classroom1.fromJson(first)).toList();

      }else{
        throw Exception("no found data");
      }
    }catch(e){
      throw e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text("error:${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: listuses.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.lightBlue,
              child: Column(
                children: [
                  Text(listuses[index]["userId"].toString()),
                  Text(listuses[index]["id"].toString()),
                  Text(listuses[index]["title"].toString()),
                  Text(listuses[index]["body"].toString()),
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
  int? userId;
  int? id;
  String? title;
  String? body;

  classroom1({this.userId, this.id, this.title, this.body});

  classroom1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

