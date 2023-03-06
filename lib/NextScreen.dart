import 'package:flutter/material.dart';
import 'package:ingrediza_dummy1/ingredientCheck.dart';
import 'main.dart';

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
          SingleChildScrollView(
            child: Column(
              children: [
                Text('Scanned Text: $scannedText'),
                Text('Filtered Text: $filteredWords'),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
          
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ingredientCheck(
                          codes: filteredWords,
                        )),
              );
            },
            child: Text('SUBMIT'),
          )
        ],
      ),
    );
  }
}
