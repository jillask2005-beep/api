import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task121 extends StatefulWidget {
  const task121({super.key});

  @override
  State<task121> createState() => _task121State();
}

class _task121State extends State<task121> {
  List ListUse=[];
  Future<List<classroom1>> getUser ()async{
    try{
      var apiresponses=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      print(apiresponses);
      print(apiresponses.statusCode);
      if(apiresponses.statusCode==200){
        ListUse=jsonDecode(apiresponses.body);
        return ListUse.map((first)=>classroom1.fromJson(first)).toList();
      }else{
        throw Exception("no found list");
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
      body: FutureBuilder(future: getUser(), builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text("error:${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: ListUse.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.blueGrey,
              child: Column(
                children: [
                  Text(ListUse[index]["postId"].toString()),
                  Text(ListUse[index]["id"].toString()),
                  Text(ListUse[index]["name"]),
                  Text(ListUse[index]["email"]),
                  Text(ListUse[index]["body"]),

                ],
              ),
            );
          },);
        }
        else{
          return Text("no data found");
        }
      }),
    );
  }
}
class classroom1 {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  classroom1({this.postId, this.id, this.name, this.email, this.body});

  classroom1.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}

