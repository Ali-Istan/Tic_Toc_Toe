import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool IsTurn0 = true;
  bool isReset = false;

  List<String> XOrOList = ['', '', '', '', '', '', '', '', ''];
  int countWinX = 0;
  int countWinO = 0;
  int filledBox = 0;
  String winner_title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: Reset, icon: Icon(Icons.refresh))],
        backgroundColor: Colors.grey[900],
        title: Text("TicTacToe"),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          SizedBox(height: 20),
          getScoreBoard(),
          SizedBox(height: 20),
          Visibility(
            visible: isReset,
            child: getResultButton(),
          ),
          SizedBox(height: 20),
          getGrid(),
          getTurn(),
        ],
      ),
    );
  }

  //region Test
  Widget getResultButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white, width: 1),
      ),
      onPressed: () {
        Reset();
      },
      child: Text(
        winner_title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //endregion

  Widget getTurn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        isReset
            ? winner_title
            : IsTurn0
                ? 'Turn O'
                : 'Turn X',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget getGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (XOrOList[index] == '') {
                Tabed(index);
              }
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  XOrOList[index],
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color:
                          XOrOList[index] == "X" ? Colors.white : Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void Tabed(int index) {
    if (!isReset)
      setState(() {
        if (IsTurn0) {
          XOrOList[index] = 'O';

          filledBox += 1;
        } else {
          XOrOList[index] = 'X';
          filledBox += 1;
        }

        IsTurn0 = !IsTurn0;
        CheckWinner();
      });
  }

  void CheckWinner() {
    if (XOrOList[0] == XOrOList[1] &&
        XOrOList[0] == XOrOList[2] &&
        XOrOList[0] != '') {
      setResult(XOrOList[0]);
      return;
    }

    if (XOrOList[3] == XOrOList[4] &&
        XOrOList[3] == XOrOList[5] &&
        XOrOList[3] != '') {
      setResult(XOrOList[3]);
      return;
    }

    if (XOrOList[6] == XOrOList[7] &&
        XOrOList[6] == XOrOList[8] &&
        XOrOList[6] != '') {
      setResult(XOrOList[6]);
      return;
    }

    if (XOrOList[0] == XOrOList[3] &&
        XOrOList[0] == XOrOList[6] &&
        XOrOList[0] != '') {
      setResult(XOrOList[0]);
      return;
    }

    if (XOrOList[1] == XOrOList[4] &&
        XOrOList[1] == XOrOList[7] &&
        XOrOList[1] != '') {
      setResult(XOrOList[1]);
      return;
    }

    if (XOrOList[2] == XOrOList[5] &&
        XOrOList[2] == XOrOList[8] &&
        XOrOList[2] != '') {
      setResult(XOrOList[2]);
      return;
    }

    if (XOrOList[0] == XOrOList[4] &&
        XOrOList[0] == XOrOList[8] &&
        XOrOList[0] != '') {
      setResult(XOrOList[0]);
      return;
    }

    if (XOrOList[2] == XOrOList[4] &&
        XOrOList[2] == XOrOList[6] &&
        XOrOList[2] != '') {
      setResult(XOrOList[2]);
      return;
    }

    if (filledBox == 9) {
      setResult('');
    }
  }

  void setResult(String winner) {
    setState(() {
      isReset = true;

      if (winner == 'X') {
        winner_title = "Player X wins!";

        countWinX++;
      } else if (winner == 'O') {
        winner_title = "Player O wins!";
        countWinO++;
      } else {
        winner_title = "OOps! It's a draw!";
        countWinX++;
        countWinO++;
      }
    });
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Player O",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  countWinO.toString(),
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Player X",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  countWinX.toString(),
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void Reset() {
    isReset = false;
    setState(() {
      for (int i = 0; i < XOrOList.length; i++) {
        XOrOList[i] = '';
      }
      filledBox = 0;
      // XOrOList = ['', '', '', '', '', '', '', '', ''];
    });
  }
}
