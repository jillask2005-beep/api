import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class JsonPlaceholder extends StatefulWidget {
  const JsonPlaceholder({super.key});

  @override
  State<JsonPlaceholder> createState() => _JsonPlaceholderState();
}

class _JsonPlaceholderState extends State<JsonPlaceholder> {
  List userslist=[];
  Future<List<UsersClass>> getUsers() async{
    try{
      var apiResponse=await http.get(Uri.parse("jsonplaceholder.typicode.com/users"));

      print(apiResponse);
      print(apiResponse.statusCode);
      if(apiResponse.statusCode==200){
        userslist = jsonDecode(apiResponse.body);
        return  userslist.map((firstid)=>UsersClass.fromJson(firstid)).toList();

      }
      else{
        throw Exception("No users is loaded");
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
        title: Text("Json Placeholder"),
      ),
      body: FutureBuilder(future: getUsers(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        else if(snapshot.hasError){
          return Text("Error:${snapshot.error}");
        }
        else if(snapshot.hasData){
          return ListView.builder(
              itemCount: userslist.length,
              itemBuilder: (context,int index){
                return Card(
                  color: Colors.greenAccent,
                  child: Column(
                    children: [
                      Text(userslist[index]["name"]),
                      Text(userslist[index]["username"]),
                      Text(userslist[index]["email"]),
                      Text(userslist[index]["address"]["city"]),
                      Text(userslist[index]["phone"]),
                      Text(userslist[index]["company"]["name"]),
                    ],
                  ),
                );
              });
        }
        else{
          return Text("No data found");
        }
      }),
    );
  }
}


//class
class UsersClass {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  UsersClass(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.address,
        this.phone,
        this.website,
        this.company});

  UsersClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}

