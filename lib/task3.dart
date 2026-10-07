import 'dart:convert';

import 'package:api/task%202.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class task2 extends StatefulWidget {
  const task2({super.key});

  @override
  State<task2> createState() => _task2State();
}

class _task2State extends State<task2> {
  Map<String,dynamic> mapuse={};
  Future<ClassFile>getData() async{
    try{
      var apiResponse=await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    print(mapuse);
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200){
      mapuse=jsonDecode(apiResponse.body);
      return ClassFile.fromJson(mapuse);
    }else {
      throw Exception("no data is loading");
    }
    }
    catch (e){
      print(e);
      throw e;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api"),
      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if (snapshot.hasData){
          return Column(
            children: [
              Text(mapuse["type"]),
              Text(mapuse["setup"]),
              Text(mapuse["punchline"]),
              Text(mapuse["id"].toString()),
            ],
          );
        }else{
          return Text("no data found");
        }
      }
      )
    );
  }
}

class ClassFied {
  String? type;
  String? setup;
  String? punchline;
  int? id;

  ClassFied({this.type, this.setup, this.punchline, this.id});

  ClassFied.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    setup = json['setup'];
    punchline = json['punchline'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['setup'] = this.setup;
    data['punchline'] = this.punchline;
    data['id'] = this.id;
    return data;
  }
}

