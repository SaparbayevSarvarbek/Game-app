import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mabc2/pages/result_page.dart';
import 'package:provider/provider.dart';
import '../view_model/test_view_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _listIndex = 0;
  late Timer _timer;
  int _remainingSeconds = 10000;
  final int _totalTime = 10000;
  double _progressValue = 0.0;
  StreamSubscription<List<ConnectivityResult>>? subscription;
  bool isInternetConnected = true;

  @override
  void initState() {
    super.initState();
    context.read<TestViewModel>().getQuestion();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _progressValue = 1 - (_remainingSeconds / _totalTime);
        });
      } else {
        _navigateToNextPage();
      }
    });
  }

  void _navigateToNextPage() {
    _timer.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResultPage()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List questionList = context.watch<TestViewModel>().question;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        child: Consumer<TestViewModel>(
          builder: (context, myProvider, child) {
            if (myProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        spacing: 16.0,
                        children: [
                          Text(
                            questionList[_listIndex].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          myProvider.question[_listIndex].gift.isNotEmpty
                              ? Image.network(
                                  myProvider.question[_listIndex].gift,
                                )
                              : Image.network(questionList[_listIndex].image),
                          Text(
                            questionList[_listIndex].description,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _listIndex++;
                        });
                      },
                      child: Text('Keyingi'))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
