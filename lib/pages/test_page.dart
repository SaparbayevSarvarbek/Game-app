import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/moduls/question_model.dart';
import 'package:mabc2/pages/result_page.dart';

class TestPage extends StatefulWidget {
  final List<QuestionModel> questionList;

  TestPage({Key? key, required this.questionList}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int index = 0;
  late Timer _timer;
  int _timeCounter = 0;
  List<int> times = []; // List to save timer values

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timeCounter = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeCounter++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void saveTimeAndNavigate() {
    setState(() {
      times.add(_timeCounter);
      index++;
    });
    _timer.cancel();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: widget.questionList.isEmpty
          ? Center(
              child: Text('Test mavjud emas'),
            )
          : Column(
              children: [
                Stack(
                  children: [
                    Card(
                      margin:
                          const EdgeInsets.only(right: 16, left: 16, top: 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              image: DecorationImage(
                                image: widget.questionList[index].gift.isEmpty
                                    ? NetworkImage(
                                        widget.questionList[index].image)
                                    : NetworkImage(
                                        widget.questionList[index].gift),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.questionList[index].title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  widget.questionList[index].description,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: MediaQuery.of(context).size.width / 2 - 30,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "$_timeCounter",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: index == widget.questionList.length - 1
                        ? () {
                            times.add(_timeCounter);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultPage(
                                        timeList: times,
                                    questionList: widget.questionList,
                                      )),
                            );
                          }
                        : saveTimeAndNavigate,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    child: index == widget.questionList.length - 1
                        ? Text(
                            "Tugatish",
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "Keyingisi",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
