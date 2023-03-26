import 'package:flutter/material.dart';
import 'NextScreen.dart';

class Result extends StatelessWidget {
  String myresult;

  Result({required this.myresult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HARMFUL EFFECTS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 104, 3),
        elevation: 30.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Text(
          myresult,
          style: TextStyle(
            height: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
            ]
          ),
        ),
      ),
    );
  }
}
