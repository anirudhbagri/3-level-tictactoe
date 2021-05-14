import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> board = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> player1 = [3, 3, 3];
  List<int> player2 = [3, 3, 3];
  bool player1Turn = true;
  bool gameOver = false;
  String consoleText = "";

  _tapped(int index) {
    int player = player1Turn ? 1 : -1;
    List<int> chances = player1Turn ? player1 : player2;
    setState(() {
      if (board[index] == 0) {
        print("Board is empty");
        if (chances[0] > 0) {
          board[index] = 1 * player;
          chances[0]--;
        } else if (chances[1] > 0) {
          board[index] = 2 * player;
          chances[1]--;
        } else if (chances[2] > 0) {
          board[index] = 3 * player;
          chances[2]--;
        }
        player1Turn = !player1Turn;
      } else if (board[index].abs() <= 1) {
        if (chances[1] > 0) {
          board[index] = 2 * player;
          chances[1]--;
        } else if (chances[2] > 0) {
          board[index] = 3 * player;
          chances[2]--;
        }
        player1Turn = !player1Turn;
      } else if (board[index].abs() <= 2) {
        if (chances[2] > 0) {
          board[index] = 3 * player;
          chances[2]--;
        }
        player1Turn = !player1Turn;
      }
      _checkWinner();
    });
  }

  _checkWinner() {
    if ((board[0] > 0 && board[1] > 0 && board[2] > 0) ||
        (board[3] > 0 && board[4] > 0 && board[5] > 0) ||
        (board[6] > 0 && board[7] > 0 && board[8] > 0) ||
        (board[0] > 0 && board[3] > 0 && board[6] > 0) ||
        (board[1] > 0 && board[4] > 0 && board[7] > 0) ||
        (board[2] > 0 && board[5] > 0 && board[8] > 0) ||
        (board[0] > 0 && board[4] > 0 && board[8] > 0) ||
        (board[2] > 0 && board[4] > 0 && board[6] > 0)) {
      setState(() {
        consoleText = "Player 1 Wins";
        gameOver = true;
      });
    } else if ((board[0] < 0 && board[1] < 0 && board[2] < 0) ||
        (board[3] < 0 && board[4] < 0 && board[5] < 0) ||
        (board[6] < 0 && board[7] < 0 && board[8] < 0) ||
        (board[0] < 0 && board[3] < 0 && board[6] < 0) ||
        (board[1] < 0 && board[4] < 0 && board[7] < 0) ||
        (board[2] < 0 && board[5] < 0 && board[8] < 0) ||
        (board[0] < 0 && board[4] < 0 && board[8] > 0) ||
        (board[2] < 0 && board[4] < 0 && board[6] < 0)) {
      setState(() {
        gameOver = true;
        consoleText = "Player 2 Wins";
      });
    }
  }

  resetGame() {
    setState(() {
      board = [0, 0, 0, 0, 0, 0, 0, 0, 0];
      player1 = [3, 3, 3];
      player2 = [3, 3, 3];
      player1Turn = true;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!gameOver) {
      consoleText = player1Turn ? 'Player 1\'s Turn' : 'Player 2\'s Turn';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${player2[0]}O",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${player2[1]} O",
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                Text(
                  "${player2[2]}O",
                  style: TextStyle(
                    fontSize: 54,
                  ),
                ),
              ],
            ),
          ),
          if (gameOver) Expanded(child: Center(child: Text(consoleText, style: TextStyle(fontSize: 52),)),),
          if (!gameOver)
            Container(
              height: 500,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(i);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[700])),
                        child: Center(
                          child: Token(board[i]),
                        )),
                  );
                },
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${player1[0]}x",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                "${player1[1]} X",
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              Text(
                "${player1[2]}X",
                style: TextStyle(
                  fontSize: 54,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  consoleText,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              ElevatedButton(
                onPressed: resetGame,
                child: Container(
                    child: Text("Reset Game", textAlign: TextAlign.center)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Token extends StatelessWidget {
  Token(this.weight);
  final int weight;

  @override
  Widget build(BuildContext context) {
    String s = "";
    if (weight > 0)
      s = "X";
    else if (weight < 0) s = "O";
    return Container(
        child: Text(
      s,
      style: TextStyle(
        fontSize: double.tryParse(((weight.abs()) * 18).toString()),
      ),
    ));
  }
}
