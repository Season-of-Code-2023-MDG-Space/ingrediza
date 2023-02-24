# ingrediza

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() => runApp(MaterialApp(
      home: Ingrediza(),
    ));

class Ingrediza extends StatefulWidget {
  @override
  State<Ingrediza> createState() => _IngredizaState();
}

class _IngredizaState extends State<Ingrediza> {
  File? image;
  bool textScanning = false;
  String scannedText = "";

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to Pick Image $e');
    }
  }

 

  void getRecognizedText(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognizedText recognizedText = textDetector.processImage(inputImage);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 231, 231),
      appBar: AppBar(
        title: Text(
          'INGREDIZA',
          style: TextStyle(
            letterSpacing: 5.0,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'BebasNeue',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 104, 3),
        elevation: 30.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Align(
              child: Text(
                'Check Before Eat!!',
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 5.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Align(
              child: Text(
                'Click The Picture of Ingredients',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 5.0,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            if (textScanning) CircularProgressIndicator(),
            image != null
                ? Image.file(
                    image!,
                    height: 100,
                    width: 300,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 300,
                    height: 100,
                    padding: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      'DROP YOUR IMAGES HERE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pickImage(ImageSource.camera);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Color.fromARGB(255, 24, 58, 41),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                    ),
                  ),
                  child: const Text('CAMERA'),
                ),
                SizedBox(
                  width: 50.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      pickImage(ImageSource.gallery);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Color.fromARGB(255, 24, 58, 41),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5.0,
                    ),
                  ),
                  child: Text('GALLERY'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

