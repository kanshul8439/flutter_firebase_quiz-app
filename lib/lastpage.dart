import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/main.dart';
import 'ReusableCard.dart';
import 'Backofstack.dart';

const info = TextStyle(fontSize: 20, color: Colors.white);
const info2 = TextStyle(fontSize: 15, color: Colors.white);

class LastPage extends StatelessWidget {
  LastPage({this.pctquiz, this.rightq, this.wrongq, this.size});
  final double pctquiz;
  final int rightq;
  final int wrongq;
  final int size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Results")),
        ),
        //backgroundColor: Color(0xFF0A0E21),
        body: Stack(
          children: <Widget>[
            Back(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    RoundProgressButton(
                      score: (rightq / size).toDouble(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white70,
                            width: 2,
                          ),
                          color: Colors.blueGrey),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      color: Colors.blueAccent),
                                  child: Column(
                                    children: [
                                      Text(
                                        "$pctquiz%",
                                        style: info,
                                      ),
                                      Text("Completed", style: info2),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      color: Colors.black),
                                  child: Column(
                                    children: [
                                      Text("$size", style: info),
                                      Text("Questions", style: info2)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      color: Colors.green),
                                  child: Column(
                                    children: [
                                      Text("$rightq", style: info),
                                      Text("Correct", style: info2),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red),
                                  child: Column(
                                    children: [
                                      Text("$wrongq", style: info),
                                      Text("Incorrect", style: info2)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Reusablecard(
                                colour: Colors.white,
                                cardchild: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.redo,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Text(
                                        "Reset",
                                        style: info.copyWith(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Reusablecard(
                                colour: Colors.white,
                                cardchild: TextButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.times,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      Text(
                                        "Quit",
                                        style: info.copyWith(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class RoundProgressButton extends StatelessWidget {
  final double score;
  RoundProgressButton({this.score});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: 100,
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Score",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              Text(
                "${score * 100}%",
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(width: 3),
          borderRadius: BorderRadius.all(
            Radius.circular(200),
          ),
          color: Colors.yellow,
        ),
      ),
    );
  }
}
