import 'dart:convert';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'NextScreen.dart';
class chatgpt extends StatefulWidget {
String result;
   chatgpt({required this.result});

  @override
  State<chatgpt> createState() => _chatgptState();
}

class _chatgptState extends State<chatgpt> {

  Future<void> searchOpenAI(String textToSearch) async {
    final apiKey = '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';
    final endpoint = 'https://api.openai.com/v1/engines/davinci/search';
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json'
    };
    final data = {
      'documents': [textToSearch],
      'query': '',
      'max_rerank': 10
    };

    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['data'];
      // Process results as needed
    } else {
      print(
          'Error searching OpenAI API: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
  
  


