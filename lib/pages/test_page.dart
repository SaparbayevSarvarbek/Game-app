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
  int _listIndex = 2;
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
        backgroundColor: const Color(0xFF6D5ED2),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        child: Consumer<TestViewModel>(
          builder: (context, myProvider, child) {
            return myProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: myProvider.question.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10,
                        child: Column(
                          spacing: 16.0,
                          children: [
                            Text(myProvider.question[index].title),
                            myProvider.question[index].gift
                                ? Image.network(
                                    myProvider.question[index].image)
                                : Image.network(
                                    myProvider.question[index].gift),
                            Text(myProvider.question[index].description),
                          ],
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }
}
