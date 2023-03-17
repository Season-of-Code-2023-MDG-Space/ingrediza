import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ingrediza_dummy1/loading.dart';
import 'logic.dart';
import 'UI.dart';
import 'NextScreen.dart';
import 'chat.dart';
import 'loading.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => loading(),
        '/UI': (context) => UI(),
      },
    ));
