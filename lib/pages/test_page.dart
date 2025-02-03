import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mabc2/pages/result_page.dart';
import 'package:provider/provider.dart';

import '../view_model/test_view_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _listIndex = 2;
  late Timer _timer;
  int _remainingSeconds = 10;
  final int _totalTime = 10;
  double _progressValue = 0.0;
  StreamSubscription<List<ConnectivityResult>>? subscription;
  bool isInternetConnected = true;

  @override
  void initState() {
    super.initState();
    context.read<TestViewModel>().getQuestion();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
          bool isConnected= await InternetConnectionChecker().hasConnection;
      setState(() {
        isInternetConnected = isConnected;
      });
    });
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
    List questionList = context
        .watch<TestViewModel>()
        .question;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: const Color(0xFF6D5ED2),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 300,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          questionList[_listIndex].image,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(questionList[_listIndex].title),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(questionList[_listIndex].description),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: _progressValue),
                    duration: const Duration(milliseconds: 900),
                    builder: (context, value, _) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              value: value,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<
                                  Color>(Colors.blue),
                            ),
                          ),
                          Text(
                            "$_remainingSeconds",
                            style: const TextStyle(fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text('Keyingisi')),
          ],
        ),
      ),
    );
  }
}
