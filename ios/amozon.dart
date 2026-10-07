import 'package:flutter/material.dart';
class amazon extends StatefulWidget {
  const amazon({super.key});

  @override
  State<amazon> createState() => _amazonState();
}

class _amazonState extends State<amazon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 220,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(""))),
          )
        ],
      ),
    );
  }
}
