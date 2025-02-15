import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/pages/first_test_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Timer? _timer;
  bool isClick = false;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  List scoreBall = [];

  void _toggleTimer() {
    isClick = true;
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
        _isRunning = false;
      } else {
        _elapsedSeconds = 0;
        _isRunning = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _elapsedSeconds++;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        elevation: 10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset('assets/images/game1.png'),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: CircularProgressIndicator(
                                              value:
                                                  (_elapsedSeconds % 60) / 60,
                                              strokeWidth: 5,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(
                                                Colors.blueAccent,
                                              ),
                                              backgroundColor:
                                                  Colors.grey.shade300,
                                            ),
                                          ),
                                          Text(
                                            '${_elapsedSeconds}s',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tangalarni joylashtirish',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'O\'ng qo\'l bilan bajaring',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      '• 3-4 yoshli bolalar uchun 6 tanga',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      '• 5-6 yoshli bolalar uchun 12 tanga',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      '• Maksimal 2 ta sinov',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _toggleTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_isRunning ? 'Stop' : 'Start'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_isRunning) {
                          _timer?.cancel();
                          _isRunning = false;
                        }
                        calculateScore(_elapsedSeconds);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FirstTestPage(list: scoreBall),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      });
                    },
                    child: const Text('Keyingi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateScore(int score) {
    if (isClick) {
      if (score <= 13) {
        scoreBall.add(15);
      } else if (score == 14) {
        scoreBall.add(14);
      } else if (score == 15) {
        scoreBall.add(13);
      } else if (score == 16) {
        scoreBall.add(12);
      } else if (score == 17) {
        scoreBall.add(11);
      } else if (score == 18) {
        scoreBall.add(10);
      } else if (score == 19) {
        scoreBall.add(9);
      } else if (score == 20) {
        scoreBall.add(7);
      } else if (score >= 21 && score <= 22) {
        scoreBall.add(6);
      } else if (score == 23) {
        scoreBall.add(5);
      } else if (score >= 24 && score <= 25) {
        scoreBall.add(4);
      } else {
        scoreBall.add(1);
      }
    } else {
      scoreBall.add(0);
    }
  }
}
