import 'package:chat_gpt_api/app/api/api.dart';
import 'package:chat_gpt_api/app/chat_gpt.dart';
import 'package:chat_gpt_api/app/model/data_model/completion/completion.dart';
import 'package:chat_gpt_api/app/model/data_model/completion/completion_request.dart';
import 'package:chat_gpt_api/app/model/data_model/image/image_request.dart';
import 'package:chat_gpt_api/app/model/data_model/image/images.dart';
import 'package:chat_gpt_api/app/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'logic.dart';
import 'package:chat_gpt_api/chat_gpt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String result;

  const Chat({required this.result});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Future<String>? resultFuture;
  final chatGpt = ChatGPT.builder(
    token: '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',
  );

  @override
  void initState() {
    super.initState();
    //resultFuture = complete();
    print("ho rha h");
  }

  void complete() async {
    try {
      var response = http.get(Uri.parse("https://api.openai.com/v1/models"),
          headers: {
            "Authorization":
                "Bearer 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 "
          });
      // Completion? completion = await chatGpt.textCompletion(
      //   request: CompletionRequest(
      //     prompt: "Dangers of eating ${widget.result}",
      //     maxTokens: 256,
      //   ),
      // );
      // if (kDebugMode) {
      //   print(completion);
      // } else {
      //   print('do it');
      // }

      // if (completion != null && completion.choices?.isNotEmpty == true) {
      //   return completion.choices!.first.text ?? '';
      // } else {
      //   print('Completion is null or empty');
      //   return '';
      // }
    } catch (e) {
      print('Error completing text: $e');
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
          onPressed: () {
            complete();
          },
        ),
        // child: FutureBuilder<String>(
        //   future: resultFuture,
        //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //     print(snapshot);
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //         return Text(snapshot.data!);
        //       } else {
        //         return Text('No data');
        //       }
        //     } else {
        //       return CircularProgressIndicator();
        //     }
        //   },
        // ),
      ),
    );
  }
}

