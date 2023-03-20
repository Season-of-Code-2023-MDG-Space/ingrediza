import 'API.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String myresult;

   Result({required this.myresult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Text(myresult),
    );
  }
}
