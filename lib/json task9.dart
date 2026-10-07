import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task0 extends StatefulWidget {
  const task0({super.key});

  @override
  State<task0> createState() => _task0State();
}

class _task0State extends State<task0> {
  List listmapses=[];
  Future<List<classroom>>getData()async{
    try{
      var apiresponses=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      print(apiresponses);
      print(apiresponses.statusCode);
      if(apiresponses.statusCode==200){
        listmapses=jsonDecode(apiresponses.body);
        return listmapses.map((first)=>classroom.fromJson(first)).toList();
      }else{
        throw Exception("no found data");
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
          return Text("error${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: listmapses.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.grey,
              child: Column(
                children: [
                  Text(listmapses[index]["userId"].toString()),
                  Text(listmapses[index]["id"].toString()),
                  Text(listmapses[index]["title"].toString()),
                  Text(listmapses[index]["completed"].toString()),
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

class classroom {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  classroom({this.userId, this.id, this.title, this.completed});

  classroom.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}

