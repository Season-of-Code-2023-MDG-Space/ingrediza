import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'NextScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

mixin logic_mixin<UI extends StatefulWidget> on State<UI> {
  XFile? imageFile;
  bool textScanning = false;
  String scannedText = "";
  String filterWords = "";

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});

        getRecognizedText(pickedImage);
      }
    } on PlatformException catch (e) {
      textScanning = false;
      imageFile = null;
      print('Failed to Pick Image $e');
      setState(() {});
    }
  }

  void getRecognizedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  void seprateWords(String paragraph) {
    List<String> words = paragraph.split(' ');
    String previousWord = '';

    for (String word in words) {
      if (previousWord == 'INS') {
        filterWords = filterWords + "INS " + word + ',' + "\n";
      }
      if (previousWord == 'e') {
        filterWords = filterWords + "e" + word + ',' + "\n";
      }
      if (previousWord == '(INS') {
        filterWords = filterWords + "INS " + word + ',' + "\n";
      }
      previousWord = word;
    }
  }
}
