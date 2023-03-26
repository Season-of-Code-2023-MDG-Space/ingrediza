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

  NextScreen({required this.scannedText, required this.filteredWords});

  @override
  Future<String> createPost() async {
    print('hello');
    print('$filteredWords');
    final response = await http.post(
      Uri.parse('https://chatgpt-openai.p.rapidapi.com/chat-completion'),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': '3824ee5d2dmshd89e28934e257bap1296e2jsn11ce2e567b44',
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
      resizeToAvoidBottomInset: false,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                child: RichText(
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
                    String data = snapshot.data;

                    data = data.replaceAll("role", "");
                    data = data.replaceAll("assistant", "");
                    data = data.replaceAll("content", "");
                    data = data.replaceAll(":", "");
                    data = data.replaceAll("\n\n", "");
                    data = data.replaceAll("\n\nAs", "");
                    data = data.replaceAll("{", "");
                    data = data.replaceAll("}", "");
                    data = data.replaceAll(".}", "");
                    data = data.replaceAll("\'", "");
                    data = data.replaceAll("\"", "");
                    data = data.replaceAll("\n\nAsINS", "INS");
                    data = data.replaceAll("\n\nINS", "INS");
                    Future.delayed(Duration.zero, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Result(
                            myresult: data,
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
        ),
      ),
    );
  }
}
