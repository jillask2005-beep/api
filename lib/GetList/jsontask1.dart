import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class jsontask1 extends StatefulWidget {
  const jsontask1({super.key});

  @override
  State<jsontask1> createState() => _jsontask1State();
}

class _jsontask1State extends State<jsontask1> {
  List useList=[];
  Future<List<classroom>> getUse() async{
    try{
      var apiresponses=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      print(apiresponses);
      print(apiresponses.statusCode);
        useList=jsonDecode(apiresponses.body);
      if(apiresponses.statusCode==200){
        return useList.map((first)=>classroom.fromJson(first)).toList();

      }else {
        throw Exception("no list found");
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
      body: FutureBuilder(future: getUse(), builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("error:${snapshot.error}");
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: useList.length, itemBuilder: (context, int index) {
            return Card(
              color: Colors.yellow,
              child: Column(
                children: [
                  Text(useList[index]["userId"].toString()),
                  Text(useList[index]["id"].toString()),
                  Text(useList[index]["title"].toString()),
                  Text(useList[index]["completed"].toString()),


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

