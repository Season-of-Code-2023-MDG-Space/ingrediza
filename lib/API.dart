import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NextScreen.dart';

class API extends StatefulWidget {
  String result;
  API({required this.result});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  Future<http.Response> createPost(String apiUrl, String apiKey,
      String question, int max_response_time) async {
    print('hello');
    final response = await http.post(
      Uri.parse('https://you-chat-gpt.p.rapidapi.com/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '9c4c860f9amsh5f830f434dd1156p11b62bjsne368149a250c',
      },
      body: jsonEncode(<String, dynamic>{
        "question": question,
        "max_response_time": max_response_time,
      }),
    );

    if (response.statusCode == 200) {
      print('Successful response: ${response.body}');
      return response;
    } else {
      print('Error response: ${response.statusCode}');
      print('Error message: ${response.body}');
      throw Exception('Failed to create post.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Color.fromARGB(255, 35, 71, 37),
          child: Text(
            'Harmful Effects',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('submit'),
          onPressed: () async {
            print('hello');
            final response = await createPost(
                'https://you-chat-gpt.p.rapidapi.com/',
                '9c4c860f9amsh5f830f434dd1156p11b62bjsne368149a250c',
                'Dangers of drinking alcohol',
                30);
          },
        ),
      ),
    );
  }
}
