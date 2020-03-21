import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/map_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red[800],
      ),
      routes: {
        '/': (context) => HomePage(),
        '/map': (context) => MapPage(),
      },
    );
  }
}
