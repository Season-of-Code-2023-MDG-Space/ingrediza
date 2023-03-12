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

class chat extends StatefulWidget {
  chat({Key? key}) : super(key: key);

  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  Future<String>? resultFuture;
  final chatGpt = ChatGPT.builder(
    token: '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',
  );

  Future<String> complete() async {
    try {
      Completion? completion = await chatGpt.textCompletion(
        request: CompletionRequest(
          prompt: "Dangers of drinking alcohol ",
          maxTokens: 256,
        ),
      );
      if (kDebugMode) {
        print(completion?.choices);
      }

      if (completion != null && completion.choices?.isNotEmpty == true) {
        return completion.choices!.first.text ?? '';
      } else {
        print('Completion is null or empty');
        return '';
      }
    } catch (e) {
      print('Error completing text: $e');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    resultFuture = complete();
    print("ho rha h");
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
        child: FutureBuilder<String>(
          future: resultFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Text(snapshot.data!);
              } else {
                return Text('No data');
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// class chat extends StatelessWidget {
//   String result;
//   chat({required this.result});

//   final chatGpt = ChatGPT.builder(
//       token: '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');

//   void complete() async {
//     print('karo');
//     print(result);
//     try {
//       Completion? completion = await chatGpt.textCompletion(
//         request: CompletionRequest(
//           prompt: "Dangers of drinking alcohol ",
//           maxTokens: 256,
//         ),
//       );
//       if (kDebugMode) {
//         print(completion?.choices);
//       }
//     } catch (e) {
//       print('Error completing text: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     complete();
//     return Scaffold(
//       appBar: AppBar(
//         title: Title(
//           color: Color.fromARGB(255, 35, 71, 37),
//           child: Text(
//             'Harmful Effects',
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       body: Text('hello'),
//     );
//   }
// }
