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
import 'logic.dart';

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> with logic_mixin {
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
              alignment: Alignment.center,
              child: Text(
                'Click The Picture of Ingredients',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            if (textScanning) const CircularProgressIndicator(),
            if (!textScanning && imageFile == null)
              Container(
                width: 300,
                height: 100,
                color: Colors.grey[300]!,
              ),
            if (imageFile != null)
              SizedBox(
                width: 300,
                height: 100,
                child: SingleChildScrollView(
                  child: Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.cover,
                  ),
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
                    pickImage(ImageSource.camera);
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
                  width: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
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
            SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              onPressed: () {
                seprateWords(scannedText);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NextScreen(
                            scannedText: scannedText,
                            filteredWords: filterWords,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Color.fromARGB(255, 0, 104, 3),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5.0,
                ),
              ),
              child: Text('SUBMIT'),
            )
          ],
        ),
      ),
    );
  }
}
