import 'dart:convert';

import 'package:api/GetMethod/Apitask1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class task4 extends StatefulWidget {
  const task4({super.key});

  @override
  State<task4> createState() => _task4State();
}

class _task4State extends State<task4> {
  Map<String,dynamic> map={};
  Future<Classfile>getData() async{
    try{
      var apiResponse=await http.get(Uri.parse("https://api.ipify.org/?format=json"));
      print(map);
      print(apiResponse.statusCode);
      if(apiResponse.statusCode==200){
        map=jsonDecode(apiResponse.body);
        return Classfile.fromJson(map);
      }else{
        throw Exception("no found the data");
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
      body:  FutureBuilder(future: getData(), builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
          child:   CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [

              ],

            ),
          );
        }else{
          return Text("no data found");
        }
      }


      ),
    );
  }
}

class Classfile{
  String? ip;

  Classfile({this.ip});

  Classfile.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    return data;
  }
}



