import 'package:flutter/material.dart';
import 'package:ingrediza_dummy1/chatgpt.dart';
import 'API.dart';
import 'main.dart';
import 'logic.dart';
import 'chat.dart';
import 'UI.dart';

class NextScreen extends StatelessWidget {
  final String scannedText;
  final String filteredWords;

  NextScreen({required this.scannedText, required this.filteredWords});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Text and Codes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Scanned Text: $scannedText'),
                  Text('Filtered Text: $filteredWords'),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
             //chat(result: filteredWords);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => API(
                       result: filteredWords,         
                          )
                          ),
                );
            },
            child: Text('SUBMIT'),
          )
        ],
      ),
    );
  }
}
