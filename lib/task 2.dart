import 'dart:convert';

import 'package:api/GetMethod/Apitask1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class sri extends StatefulWidget {
  const sri({super.key});

  @override
  State<sri> createState() => _sriState();

}

class _sriState extends State<sri> {
  Map<String, dynamic> usemap = {};

  Future<Classfile> getData() async {
    try {
      var apiResponses = await http.get(
          Uri.parse("https://ipinfo.io/161.185.160.93/geo?formad=json"));
      print(usemap);
      print(apiResponses.statusCode);
      if (apiResponses.statusCode == 200) {
        usemap = jsonDecode(apiResponses.body);
        return Classfile.fromJson(usemap);
      } else {
        throw Exception("no data is loading");
      }
    }
    catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APi "),centerTitle: true,
      ),
      body: FutureBuilder(future:getData() , builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
    }
        else if(snapshot.hasError){
          return Text("error:${snapshot.error}");
    }
        else if(snapshot.hasData){
          return Column(
          children: [
            Text(usemap["ip"]),
            Text(usemap["city"]),
    Text(usemap["region"]),
    Text(usemap["country"]),
    Text(usemap["loc"]),
    Text(usemap["org"]),
    Text(usemap["postal"]),
    Text(usemap["timezone"]),
    Text(usemap["readme"])
    ],
          );
    }
        else{
          return Text("No data found");
        }
    }
      )
    );
  }
}



class ClassFile {
String? ip;
String? city;
String? region;
String? country;
String? loc;
String? org;
String? postal;
String? timezone;
String? readme;

ClassFile({this.ip, this.city, this.region, this.country, this.loc, this.org, this.postal, this.timezone, this.readme});

ClassFile.fromJson(Map<String, dynamic> json) {
ip = json['ip'];
city = json['city'];
region = json['region'];
country = json['country'];
loc = json['loc'];
org = json['org'];
postal = json['postal'];
timezone = json['timezone'];
readme = json['readme'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['ip'] = this.ip;
data['city'] = this.city;
data['region'] = this.region;
data['country'] = this.country;
data['loc'] = this.loc;
data['org'] = this.org;
data['postal'] = this.postal;
data['timezone'] = this.timezone;
data['readme'] = this.readme;
return data;
}
}

