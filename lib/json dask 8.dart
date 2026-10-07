import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task9 extends StatefulWidget {
  const task9({super.key});

  @override
  State<task9> createState() => _task9State();
}

class _task9State extends State<task9> {
  List listmaps=[];
  Future<List<classroom1>> getData() async{
    try{
      var apiresponses=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      print(apiresponses);
      print(apiresponses.statusCode);
      if(apiresponses.statusCode==200){
        listmaps=jsonDecode(apiresponses.body);
        return listmaps.map((first)=>classroom1.fromJson(first)).toList();
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
        }else if (snapshot.hasError){
          return Text("error${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: listmaps.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.purpleAccent,
              child: Column(
                children: [
                  Text(listmaps[index]["postId"].toString()),
                  Text(listmaps[index]["id"].toString()),
                  Text(listmaps[index]["name"].toString()),
                  Text(listmaps[index]["email"].toString()),
                  Text(listmaps[index]["body"].toString()),
                ],
              ),
            );
          },);
        }else{
          return Text("no found return");
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

