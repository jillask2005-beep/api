import 'dart:convert';

import 'package:api/GetMethod/Apitask1.dart';
import 'package:api/api%20with%20image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Student_Crud extends StatefulWidget {
  const Student_Crud({super.key});

  @override
  State<Student_Crud> createState() => _Student_CrudState();
}

class _Student_CrudState extends State<Student_Crud> {
  void initState(){
    super.initState();
    setState(() {
       getAllStudents();
    });

  }

  TextEditingController name=TextEditingController();
  TextEditingController rollno=TextEditingController();
  TextEditingController year=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController gender=TextEditingController();



    void addStudent() async {
      try {
        var apiResponse = await http.post(
            Uri.parse("http://92.205.109.210:8051/api/create"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "name": name.text,
              "rollno":rollno.text,
              "year": year.text,
              "department": dept.text,
              "gender": gender.text,
            })
        );

        if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
          var responseBody = jsonDecode(apiResponse.body);
          var message = responseBody["message"];
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)));

          name.clear();
          dept.clear();
          rollno.clear();
          gender.clear();
          year.clear();
        }
        else {

          throw Exception("Failed to add student");
        }
      }

      catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())));
        throw e;
      }
    }
  Map<String, dynamic> mapapi = {};
    List students=[];
  Future<List> getAllStudents() async {
    try {
      var apiresponses = await http.get(
        Uri.parse("http://92.205.109.210:8051/api/getall"),
      );
      print(apiresponses.statusCode);

      if (apiresponses.statusCode == 201) {
        mapapi = jsonDecode(apiresponses.body);
        students=mapapi["data"];
        print(students);
        return students;
      } else {
        throw Exception("No data found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }


  }
  Future<void> updatestudent(int id) async {
    try{
      var responses=await http.post(Uri.parse("http://92.205.109.210:8051/api/update/$id"),
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
          getAllStudents();
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
  Future<void>deletedstudent(int id)async{
    try{
      var responses=await http.post(Uri.parse( "http://92.205.109.210:8051/api/delete/$id"));
      print(responses.statusCode);
      print(responses.body);
      if(responses.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Student Deleted Successfully"),
          ),
        );
        setState(() {
          getAllStudents();

        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Delete failed: ${responses.body}"),
          ),
        );
      }
    }catch (e){
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student-Crud"),
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                    labelText: "Enter Name",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: rollno,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Roll No",
                    labelText: "Enter Roll No",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: year,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Year",
                    labelText: "Enter Year",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dept,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Department",
                    labelText: "Enter Department",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: gender,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Gender",
                    labelText: "Enter Gender",
                  ),
                ),
              ),

              const SizedBox(height: 5),

              ElevatedButton(
                onPressed: () {
                  addStudent();
                },
                child: const Text("Save"),
              ),

              const SizedBox(height: 10),

              FutureBuilder(
                future: getAllStudents(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                      ),
                    );
                  }

                  else if (snapshot.hasData) {

                    return ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),

                      itemCount: students.length,

                      itemBuilder: (context, index) {

                        return Card(
                          color: Colors.pink,

                          child: Column(
                            children: [

                              Text(
                                "Name: ${students[index]["name"]}",
                              ),

                              Text(
                                "Roll No: ${students[index]["rollno"]}",
                              ),

                              Text(
                                "Year: ${students[index]["year"]}",
                              ),

                              Text(
                                "Department: ${students[index]["department"]}",
                              ),

                              Text(
                                "Gender: ${students[index]["gender"]}",
                              ),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [

                                  // EDIT
                                  IconButton(
                                    onPressed: () {

                                      name.text =
                                          students[index]["name"]
                                              .toString();

                                      rollno.text =
                                          students[index]["rollno"]
                                              .toString();

                                      year.text =
                                          students[index]["year"]
                                              .toString();

                                      dept.text =
                                          students[index]
                                          ["department"]
                                              .toString();

                                      gender.text =
                                          students[index]["gender"]
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
                                                      students[index]
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

                                  // DELETE
                                  IconButton(
                                    onPressed: () {

                                      deletedstudent(
                                        students[index]
                                        ["studentId"],
                                      );
                                    },

                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  else {
                    return const Text(
                      "No data found",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    }}