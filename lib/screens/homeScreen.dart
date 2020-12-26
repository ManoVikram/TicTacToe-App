import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/boxButton.dart';
import '../widgets/customDialogBox.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> player1 = [];
  List<int> player2 = [];
  int currentPlayer = 1;
  int winner = 0;

  List<BoxButtonData> boxes, dummy;

  void initState() {
    super.initState();
    boxes = initialize();
    dummy = boxes;
  }

  List<BoxButtonData> initialize() {
    player1 = [];
    player2 = [];
    boxes = [];
    currentPlayer = 1;
    return context.read<BoxButton>().boxes;
  }

  void resetGame() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    print(boxes[0].value);
    setState(() {
      for (var box in boxes) {
        box.value = null;
        box.chosen = false;
        box.backgroundColor = Colors.grey;
        box.value = "";
      }
      winner = 0;
      player1 = [];
      player2 = [];
      currentPlayer = 1;
    });
    print(player1);
  }

  void checkWinner() {
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    } else if (player1.contains(4) &&
        player1.contains(5) &&
        player1.contains(6)) {
      winner = 1;
    } else if (player2.contains(4) &&
        player2.contains(5) &&
        player2.contains(6)) {
      winner = 2;
    } else if (player1.contains(7) &&
        player1.contains(8) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player1.contains(1) &&
        player1.contains(4) &&
        player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(4) &&
        player2.contains(7)) {
      winner = 2;
    } else if (player1.contains(2) &&
        player1.contains(5) &&
        player1.contains(8)) {
      winner = 1;
    } else if (player2.contains(2) &&
        player2.contains(5) &&
        player2.contains(8)) {
      winner = 2;
    } else if (player1.contains(3) &&
        player1.contains(6) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(6) &&
        player2.contains(9)) {
      winner = 2;
    } else if (player1.contains(1) &&
        player1.contains(5) &&
        player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(5) &&
        player2.contains(9)) {
      winner = 1;
    } else if (player1.contains(3) &&
        player1.contains(5) &&
        player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(5) &&
        player2.contains(7)) {
      winner = 1;
    }

    if (winner == 0) {
      return;
    } else if (winner == 1) {
      showDialog(
        context: context,
        builder: (_) => CustomDialogBox(
          "PLAYER 1 WON",
          "PRESS THE RESET BUTTON TO START AGAIN",
          resetGame,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => CustomDialogBox(
          "PLAYER 2 WON",
          "PRESS THE RESET BUTTON TO START AGAIN",
          resetGame,
        ),
      );
    }
  }

  void computerPlay() {
    List<int> emptyCells = [];
    List<int> list = List.generate(9, (index) => index + 1);

    for (int boxId in list) {
      if (!(player1.contains(boxId) || player2.contains(boxId))) {
        emptyCells.add(boxId);
      }
    }

    int randomIndex = Random().nextInt(emptyCells.length - 1);
    int cellId = emptyCells[randomIndex];
    int index = boxes.indexWhere((element) => element.id == cellId);
    chooseBox(boxes[index]);
  }

  void chooseBox(BoxButtonData box) {
    if (currentPlayer == 1) {
      box.value = "X";
      box.backgroundColor = Colors.teal;

      currentPlayer = 2;
      player1.add(box.id);
    } else {
      box.value = "O";
      box.backgroundColor = Colors.orangeAccent;

      currentPlayer = 1;
      player2.add(box.id);
    }
    box.chosen = true;
    checkWinner();

    if (winner == 0) {
      if (boxes.every((element) => element.value != "")) {
        showDialog(
          context: context,
          builder: (_) => CustomDialogBox(
            "GameTied",
            "Press RESET to start again.",
            resetGame,
          ),
        );
      } else {
        currentPlayer == 2 ? computerPlay() : null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("TIC TAC TOE"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              padding: const EdgeInsets.all(10),
              itemBuilder: (contxt, index) => SizedBox(
                height: size.height / 4,
                width: size.width / 3,
                child: RaisedButton(
                  onPressed: boxes[index].chosen
                      ? null
                      : () {
                          setState(() {
                            chooseBox(boxes[index]);
                          });
                        },
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    boxes[index].value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  color: boxes[index].backgroundColor,
                  disabledColor: boxes[index].backgroundColor,
                ),
              ),
              itemCount: boxes.length,
            ),
          ),
          RaisedButton(
            onPressed: resetGame,
            padding: const EdgeInsets.all(20.0),
            color: Colors.red,
            child: Text(
              "Clear",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
