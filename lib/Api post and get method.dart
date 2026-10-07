import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Postandget extends StatefulWidget {
  const Postandget({super.key});

  @override
  State<Postandget> createState() => _PostandgetState();
}

class _PostandgetState extends State<Postandget> {
  void initstate(){
    super.initState();
    setState(() {
      getStudent();

    });
  }
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController dept = TextEditingController();
  TextEditingController gender = TextEditingController();
  String studentId="";

  List<dynamic>mapapilist=[];
  Future<List>getStudent()async{
    try{
      var apiresponse=await http.get(Uri.parse("http://92.205.109.210:8051/api/getall"));
      print(apiresponse);
      print(apiresponse.statusCode)
      ;
      if(apiresponse.statusCode==201){
        var responseBody = jsonDecode(apiresponse.body);
        mapapilist= responseBody["data"];
        return mapapilist;
      }else{
        throw Exception("no data found");
      }
    }catch (e){
      throw e;
    }
  }
  Future<void> updatestudent(int id) async {
    try{
      var responses=await http.put(Uri.parse("http://92.205.109.210:8051/api/update/$id"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name":name.text,
          "rollno":rollno.text,
          "year":year.text,
          "department":dept.text,
          "gender":gender.text
        }),
      );
      print(responses.statusCode);
      print(responses.body);
      if(responses.statusCode==200||responses.statusCode==201){
        var responseBody=jsonDecode(responses.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseBody["message"]??"Student Updated Successfully",)));
        setState(() {
        });
        name.clear();
        rollno.clear();
        year.clear();
        dept.clear();
        gender.clear();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update failed: ${responses.body}")));

      }

    }catch (e){
      throw e;
    }
  }
  Future<void>deleteddtudent(int id)async{
    try{
      var apiresponses=await http.delete(Uri.parse("http://92.205.109.210:8051/api/delete/$id"));
      print(apiresponses.statusCode);
      print(apiresponses.body);
      if(apiresponses.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Deleted Successfully")));
        setState(() {
          getStudent();

        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delete failed: ${apiresponses.body}")));
      }
    }catch (e){
      throw e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  labelText: "Enter your name",
                  hintText: "name",

                ),
              ),
            ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: rollno,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                    labelText: "rollno",
                  hintText: "Enter your rollno",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: year,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter year",
                  hintText: "year",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: dept,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your department",
                  hintText: "department",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: gender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter gender",
                  hintText: "gender",
                ),
              ),
            ),
            SizedBox(height: 5,),
            ElevatedButton(onPressed: (){}, child: Text("Save")),
            SizedBox(height: 5,),
            FutureBuilder(future: getStudent(), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Text("Error${snapshot.error}");
              }else if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap:true,physics:NeverScrollableScrollPhysics(),
                  itemCount: mapapilist.length,itemBuilder: (context,int index){
                  return Card(
                    color: Colors.pink,
                    child: Column(
                      children: [
                        Text(mapapilist[index]["name"].toString()),
                        Text(mapapilist[index]["rollno"].toString()),
                        Text(mapapilist[index]["year"].toString()),
                        Text(mapapilist[index]["department"].toString()),
                        Text(mapapilist[index]["gender"].toString()),
                        Text(mapapilist[index]["__v"].toString()),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {

                                name.text =
                                    mapapilist[index]["name"]
                                        .toString();

                                rollno.text =
                                    mapapilist[index]["rollno"]
                                        .toString();

                                year.text =
                                    mapapilist[index]["year"]
                                        .toString();

                                dept.text =
                                    mapapilist[index]
                                    ["department"]
                                        .toString();

                                gender.text =
                                    mapapilist[index]["gender"]
                                        .toString();

                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        title: const Text(
                                          "Update Student",
                                        ),

                                        content:
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [

                                              TextField(
                                                controller: name,
                                                decoration:
                                                const InputDecoration(
                                                  labelText: "Name",
                                                  border:
                                                  OutlineInputBorder(),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              TextField(
                                                controller: rollno,
                                                decoration:
                                                const InputDecoration(
                                                  labelText:
                                                  "Roll No",
                                                  border:
                                                  OutlineInputBorder(),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              TextField(
                                                controller: year,
                                                decoration:
                                                const InputDecoration(
                                                  labelText: "Year",
                                                  border:
                                                  OutlineInputBorder(),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              TextField(
                                                controller: dept,
                                                decoration:
                                                const InputDecoration(
                                                  labelText:
                                                  "Department",
                                                  border:
                                                  OutlineInputBorder(),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 10,
                                              ),

                                              TextField(
                                                controller: gender,
                                                decoration:
                                                const InputDecoration(
                                                  labelText: "Gender",
                                                  border:
                                                  OutlineInputBorder(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        actions: [

                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context);
                                            },
                                            child:
                                            const Text("Cancel"),
                                          ),

                                          ElevatedButton(
                                            onPressed: () {

                                              updatestudent(
                                                mapapilist[index]
                                                ["studentId"],
                                              );

                                              Navigator.pop(
                                                  context);
                                            },
                                            child:
                                            const Text("Update"),
                                          ),
                                        ],
                                      ),
                                );
                              },

                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(onPressed: (){
                              deleteddtudent(

                                    mapapilist[index]["studentId"],
                              );
                            }, icon: Icon(Icons.delete))
                          ],
                        )

                      ],
                    ),
                  );
                },);
              }else{
                return Text("no found data");
              }
            })
          ],
        ),
      ),
    );
  }
}
