import 'dart:convert';

import 'package:api/joson%20task2.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart'as http;
class task5 extends StatefulWidget {
  const task5({super.key});

  @override
  State<task5> createState() => _task5State();
}

class _task5State extends State<task5> {
  List useslis=[];
  Future<List<classroom1>> getData() async{
    try{
      var apiresponse=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
      print(apiresponse);
      print(apiresponse.statusCode);
      if(apiresponse.statusCode==200){
        useslis=jsonDecode(apiresponse.body);
        return useslis.map((first)=>classroom1.fromJson(first)).toList();

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
        title: Text("APi"),
      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if (snapshot.hasError){
          return Text("error${snapshot.error}");
        }else if(snapshot.hasData){
          return ListView.builder(itemCount: useslis.length,itemBuilder: (context,int index){
            return Card(
              color: Colors.pink,
              child: Column(
                children: [
              Text(useslis[index]["userId"].toString()),
                  Text(useslis[index]["id"].toString()),
                  Text(useslis[index]["title"].toString()),
                ],
              ),
            );
          },);
        }
        else{
          return Text("n found data");
        }
      }),
    );
  }
}
class classroom1 {
  int? userId;
  int? id;
  String? title;

  classroom1({this.userId, this.id, this.title});

  classroom1.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

