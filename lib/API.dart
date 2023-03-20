import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'NextScreen.dart';
import 'package:dio/dio.dart';
import 'result.dart';

final dio = Dio();

class API extends StatefulWidget {
  String result;
  API({required this.result});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  Future<String> createPost() async {
    print('hello');
    print('${widget.result}');
    final response = await http.post(
      Uri.parse('https://you-chat-gpt.p.rapidapi.com/'),
      headers: {
        'content-type': 'application/json',
        'X-RapidAPI-Key': 'c09e28d0a2mshd6a6e0dfc7bcad8p106d78jsn18f5991451a3',
        'X-RapidAPI-Host': 'you-chat-gpt.p.rapidapi.com'
      },
      body: jsonEncode({
        "question": 'Dangers of eating ${widget.result}',
        "max_response_time": 30,
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
            final response = await createPost();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                        myresult: response,
                      )),
            );
          },
        ),
      ),
    );
  }
}
