import 'package:flutter/material.dart';
import 'main.dart';
import 'logic.dart';
import 'UI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result.dart';

class NextScreen extends StatelessWidget {
  final String scannedText;
  final String filteredWords;
  bool _isLoading = false;
  List<String> excludedWords = [
    'role',
    ':',
    'assistant',
    'content:',
    '\n\n',
    '\n\nAs,'
  ];

  NextScreen({required this.scannedText, required this.filteredWords});

  @override
  Future<String> createPost() async {
    print('hello');
    print('$filteredWords');
    final response = await http.post(
      Uri.parse('https://chatgpt-openai.p.rapidapi.com/chat-completion'),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': 'c09e28d0a2mshd6a6e0dfc7bcad8p106d78jsn18f5991451a3',
        'X-RapidAPI-Host': 'chatgpt-openai.p.rapidapi.com'
      },
      body: jsonEncode({
        "messages": [
          {"role": "user", "content": "Dangers of eating $filteredWords"}
        ],
        "temperature": 1
      }),
    );

    if (response.statusCode == 200) {
      print('Successful response: ${response.body}');
      return response.body;
    } else {
      print('Error response: ${response.statusCode}');
      print('Error message: ${response.body}');
      throw Exception('Failed to create post.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SCANNED TEXT',
          style: TextStyle(
            letterSpacing: 5.0,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'BebasNeue',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 104, 3),
        elevation: 30.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: ListView(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'SCANNED TEXT: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 58, 41),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: '$scannedText',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'FILTERED TEXT: ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 24, 58, 41),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            TextSpan(
                              text: '$filteredWords',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: createPost(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 21, 66, 23)),
                ));
              } else if (snapshot.connectionState == ConnectionState.done) {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Result(
                        myresult: snapshot.data,
                      ),
                    ),
                  );
                });
                return Container();
              } else {
                return Text('Error: ${snapshot.error}');
              }
            },
          ),
        ],
      ),
    );
  }
}
