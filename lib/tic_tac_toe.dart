// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
// import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List gridValues = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  List leftValues = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  List colorsList= [Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70];
  var choice = "X";
  var cpu = "O";
  var winner = "";
  List winnings = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
  winnerCheck(choice) {
    for (var value in winnings) {
      if (gridValues[value[0]] == choice &&
          gridValues[value[1]] == choice &&
          gridValues[value[2]] == choice) {
        print("$choice is the winner!");
        winner = choice;
      } else if (leftValues.isEmpty) {
        winner = "draw";
      }
    }
  }

  cpuMove() {
    leftValues.shuffle();
    var value = leftValues[0];
    colorsList[gridValues.indexOf(value)]= Color.fromARGB(255, 255, 154, 154);
    gridValues[gridValues.indexOf(value)] = cpu;
    leftValues.remove(value);
    winnerCheck(cpu);
  }

  playerMove(index) {
    colorsList[index]=Color.fromARGB(255, 138, 202, 255);
    leftValues.remove(gridValues[index]);
    gridValues[index] = choice;
    winnerCheck(choice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "TIC TAC TOE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 229, 115, 115),
                Color.fromARGB(255, 100, 181, 246)
              ],
            )),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10),
                itemCount: gridValues.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                      onPressed: (winner.isEmpty)
                          ? () {
                              setState(() {
                                if (gridValues[index] == cpu ||
                                    gridValues[index] == choice) {
                                } else {
                                  playerMove(index);
                                }
                                if (leftValues.isNotEmpty) {
                                  cpuMove();
                                }
                              });
                            }
                          : () {},
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              colorsList[index])),
                      child: Center(
                        child: Text(
                          gridValues[index].toString(),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ));
                },
              ),
            ),
            SizedBox(
                height: 300,
                child: Text( (winner== "draw")?"Game Draw!":"Congrats! winner is $winner",
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){},child: const Icon(Icons.restart_alt_rounded),),
        );
  }
}
