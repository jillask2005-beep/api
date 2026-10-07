import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class image extends StatefulWidget {
  const image({super.key});

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  Map<String,dynamic>maps={};
  Future<classroom>getData() async{
    try{
      var apiresponse=await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
      print(maps);
      print(apiresponse.statusCode);
      if(apiresponse.statusCode==200){
        maps=jsonDecode(apiresponse.body);
        return classroom.fromJson(maps);
      }else{
        throw Exception("no data found ");
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

      ),
      body: FutureBuilder(future: getData(), builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "error:${snapshot.error}"
            ),
          );
        }else if (snapshot.hasData){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://images.dog.ceo/breeds/retriever-golden/n02099601_864.jpg",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          );
        }else{
          return Center(
            child: Text("no found data "),
          );
        }
      }
      ),
    );
  }
}

class classroom {
  String? message;
  String? status;

  classroom({this.message, this.status});

  classroom.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

