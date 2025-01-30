import 'package:flutter/material.dart';
import 'dart:async';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Timer _timer;
  int _remainingSeconds = 500;
  final int _totalTime = 500;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
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
      MaterialPageRoute(builder: (context) => NextPage()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: Color(0xFF6D5ED2),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: _progressValue),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    Text(
                      "$_remainingSeconds",
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToNextPage,
              child: const Text("Tugatish"),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keyingi sahifa")),
      body: const Center(
        child: Text(
          "Siz keyingi sahifaga o'tdingiz!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}