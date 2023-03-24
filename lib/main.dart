import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingrediza_dummy1/frontPage.dart';
import 'logic.dart';
import 'UI.dart';
import 'NextScreen.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => Splash(),
        '/UI': (context) => UI(),
      },
    ));
