import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/homeScreen.dart';
import './models/boxButton.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contxt) => BoxButton(),
      child: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

void main() => runApp(MyApp());
