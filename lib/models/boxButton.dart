import 'package:flutter/material.dart';

class BoxButtonData {
  final int id;
  String value;
  Color backgroundColor;
  bool chosen;

  BoxButtonData({
    @required this.id,
    this.value = "",
    this.backgroundColor = Colors.blueGrey,
    this.chosen = false,
  });
}

class BoxButton with ChangeNotifier {
  List<BoxButtonData> _boxes = [
    BoxButtonData(id: 1),
    BoxButtonData(id: 2),
    BoxButtonData(id: 3),
    BoxButtonData(id: 4),
    BoxButtonData(id: 5),
    BoxButtonData(id: 6),
    BoxButtonData(id: 7),
    BoxButtonData(id: 8),
    BoxButtonData(id: 9),
  ];

  List<BoxButtonData> get boxes => [..._boxes];
}
