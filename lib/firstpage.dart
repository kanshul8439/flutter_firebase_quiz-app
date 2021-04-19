import 'package:cloud_firestore/cloud_firestore.dart';
import 'lastpage.dart';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math' as math;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Backofstack.dart';

ImageProvider backimage1 = AssetImage("images/image2.png");
ImageProvider backimage2 = AssetImage("images/finished.jpg");
const questionstyle =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
const optionnstyle = TextStyle(fontSize: 15, color: Colors.black);

class MyHomePage extends StatefulWidget {
  static const String id = "MyHomePage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Model> questions = [];
  double leftpct = 0;
  double rightpct = 0;
  double pctquiz = 0;
  int rightq = 0;
  int wrongq = 0;
  int size = 4; //size
  double progincrement = 25; //100 by size
  double quesincrement = 25; //100 by size
  int index = 0;
  bool spinner = false;
  Widget formedwidget = CircularPercentIndicator(
    radius: 10,
  );

  final firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    try {
      setState(() {
        spinner = true;
      });
      final mess = await firestore.collection("quizdata").get();
      questions.clear();
      for (var x in mess.docs) {
        final String questiontext = x['questiontext'];
        final String answer = x['answer'];
        final String option1 = x['option1'];
        final String option2 = x['option2'];
        final String option3 = x['option3'];
        final String option4 = x['option4'];
        Model formedwidget = Model(
            questiontext: questiontext,
            answer: answer,
            option1: option1,
            option2: option2,
            option3: option3,
            option4: option4);
        questions.add(formedwidget);
        //print(x['questiontext']);
      }
      setState(() {
        index = 0;
        size = questions.length;
        progincrement = 100 / size;
        quesincrement = 100 / size;
        spinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void scorer(String option, String answer) {
    if (pctquiz != 100) {
      if (index <= size - 1) {
        if (option == answer) {
          rightq++;
          leftpct += progincrement;
        } else {
          wrongq++;
          rightpct += progincrement;
        }

        if (pctquiz < 100) pctquiz += progincrement;
        if (index + 1 < size) index++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //data();
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Center(child: Text("Assessment")),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LastPage(
                                  pctquiz: pctquiz,
                                  rightq: rightq,
                                  wrongq: wrongq,
                                  size: size,
                                )));
                  },
                  child: Icon(
                    Icons.bar_chart,
                    size: 30.0,
                  ),
                )),
          ],
        ),
        backgroundColor: Color(0xFF0A0E21),
        body: Stack(
          children: <Widget>[
            Back(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: Container(
                  child: ModalProgressHUD(
                    color: Colors.blueGrey,
                    inAsyncCall: spinner,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.circle,
                                  color: Colors.green, size: 20),
                            ),
                            Text(
                              "$rightq",
                            ),
                            Expanded(
                              flex: 4,
                              child: Baseline(
                                baseline: 50,
                                baselineType: TextBaseline.ideographic,
                                child: LinearPercentIndicator(
                                  lineHeight: 8,
                                  percent: leftpct / 100,
                                  backgroundColor: Colors.white,
                                  progressColor: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3,
                              //height: 4,
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircularPercentIndicator(
                                    backgroundColor: Colors.white,
                                    radius: 85,
                                    lineWidth: 8.0,
                                    percent: pctquiz / 100,
                                    center: Text(
                                      "${pctquiz.toInt()}%",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                flex: 4,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Baseline(
                                    baseline: 50,
                                    baselineType: TextBaseline.ideographic,
                                    child: LinearPercentIndicator(
                                      lineHeight: 8,
                                      percent: rightpct / 100,
                                      backgroundColor: Colors.white,
                                      progressColor: Colors.red,
                                    ),
                                  ),
                                )),
                            Text(
                              "$wrongq",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.circle,
                                  color: Colors.red, size: 20),
                            ),
                          ],
                        ),
                        if (questions.length > 0)
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                color: Colors.red.withOpacity(0.3)),
                            padding: EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    questions[index].questiontext,
                                    textAlign: TextAlign.center,
                                    style: questionstyle,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        scorer(questions[index].option1,
                                            questions[index].answer);
                                      });
                                    },
                                    child: Text(
                                      "A >" + questions[index].option1,
                                      style: optionnstyle,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        scorer(questions[index].option2,
                                            questions[index].answer);
                                      });
                                    },
                                    child: Text(
                                      "B >" + questions[index].option2,
                                      style: optionnstyle,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        scorer(questions[index].option3,
                                            questions[index].answer);
                                      });
                                    },
                                    child: Text(
                                      "C >" + questions[index].option3,
                                      style: optionnstyle,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      "D >" + questions[index].option4,
                                      style: optionnstyle,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        scorer(questions[index].option4,
                                            questions[index].answer);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 60.0, right: 60),
                          child: Container(
                            //height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 5),
                            child: TextButton(
                                onPressed: () {
                                  //data();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LastPage(
                                                pctquiz: pctquiz,
                                                rightq: rightq,
                                                wrongq: wrongq,
                                                size: size,
                                              )));
                                },
                                child: Text(
                                  "Submit",
                                  style: optionnstyle.copyWith(
                                      color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
