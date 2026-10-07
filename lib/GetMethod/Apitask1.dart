import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apitask1 extends StatefulWidget {
  const Apitask1({super.key});

  @override
  State<Apitask1> createState() => _Apitask1State();
}

class _Apitask1State extends State<Apitask1> {
  Map<String,dynamic>  usersmap={};
  Future<Classfile> getData() async{
    try{
      var apiResponse=await http.get(Uri.parse("https://api.ipify.org/?format=json"));

      print(usersmap);
      print(apiResponse.statusCode);
      if(apiResponse.statusCode==200){
        usersmap = jsonDecode(apiResponse.body);
        return  Classfile.fromJson(usersmap);

      }
      else{
          throw Exception("No data is loaded");
      }
    }
    catch(e){
      print(e);
      throw e;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Task-1"),
      ),
      body: FutureBuilder(future:getData() , builder: (context,snapshot){
       if(snapshot.connectionState==ConnectionState.waiting){
         return CircularProgressIndicator();
       }
       else if(snapshot.hasError){
         return Text("Error:${snapshot.error}");
       }
       else if(snapshot.hasData){
         return Column(
           children: [
             Text(usersmap["ip"])
             // Text(usersmap["activity"]??"No data"),
             // Text(usersmap["availability"]??"No data"),
             // Text(usersmap["type"]??"No data"),
             // Text(usersmap["participants"]??"No data"),
             // Text(usersmap["price"]??"No data"),
             // Text(usersmap["accessibility"]??"No data"),
             // Text(usersmap["duration"]??"No data"),
             // Text(usersmap["kidFriendly"]??"No data"),
             // Text(usersmap["link"]?? "No data"),
             // Text(usersmap["key"]??"No data"),
           ],
         );
       }
       else{
         return Text("No data found");
       }
      }),
    );
  }
}

/////////////////////////////////
// class Classfile {
//   String? activity;
//   double? availability;
//   String? type;
//   int? participants;
//   int? price;
//   String? accessibility;
//   String? duration;
//   bool? kidFriendly;
//   String? link;
//   String? key;
//
//   Classfile(
//       {this.activity,
//         this.availability,
//         this.type,
//         this.participants,
//         this.price,
//         this.accessibility,
//         this.duration,
//         this.kidFriendly,
//         this.link,
//         this.key});
//
//   Classfile.fromJson(Map<String, dynamic> json) {
//     activity = json['activity'];
//     availability = json['availability'];
//     type = json['type'];
//     participants = json['participants'];
//     price = json['price'];
//     accessibility = json['accessibility'];
//     duration = json['duration'];
//     kidFriendly = json['kidFriendly'];
//     link = json['link'];
//     key = json['key'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['activity'] = this.activity;
//     data['availability'] = this.availability;
//     data['type'] = this.type;
//     data['participants'] = this.participants;
//     data['price'] = this.price;
//     data['accessibility'] = this.accessibility;
//     data['duration'] = this.duration;
//     data['kidFriendly'] = this.kidFriendly;
//     data['link'] = this.link;
//     data['key'] = this.key;
//     return data;
//   }
// }

class Classfile {
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