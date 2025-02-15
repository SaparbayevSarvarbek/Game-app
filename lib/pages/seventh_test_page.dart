import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/pages/eighth_test_page.dart';

import '../moduls/score_model.dart';

class SeventhTestPage extends StatefulWidget {
  List list;

  SeventhTestPage({Key? key, required this.list}) : super(key: key);

  @override
  State<SeventhTestPage> createState() => _SeventhTestPageState();
}

class _SeventhTestPageState extends State<SeventhTestPage> {
  Timer? _timer;
  int _elapsedSeconds = 30;
  bool _isRunning = false;
  bool isClick = false;
  ScoreModel scoreModel = ScoreModel();

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
        _isRunning = false;
      } else {
        _elapsedSeconds = 30;
        _isRunning = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_elapsedSeconds > 0) {
              _elapsedSeconds--;
            } else {
              _timer?.cancel();
              _isRunning = false;
            }
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
                        color: Colors.transparent,
                        elevation: 10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: SizedBox(
                                width: 250,
                                height: 300,
                                child: Image.asset('assets/images/game6.png'),
                              ),
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
                                              value: (_elapsedSeconds / 30),
                                              strokeWidth: 5,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                      Color>(Colors.blueAccent),
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
                      'Bir oyoqli muvozanat',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Chap oyoq bilan bajaring',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      '• Maksimal vaqt 30 soniya',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      '• Chap oyoq uchun maksimal 2 ta sinov',
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
                  width: double.infinity,
                  height: 50,
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
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_isRunning) {
                          _timer?.cancel();
                          _isRunning = false;
                        }
                        calculateScore(_elapsedSeconds);
                        print("Vaqt qo‘shildi: ${scoreModel.results}s");
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    EighthTestPage(list: widget.list),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Keyingi'),
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
      int a = 30 - score;
      if (a <= 30 && a >= 29) {
        widget.list.add(14);
      } else if (a >= 24 && a <= 28) {
        widget.list.add(11);
      } else if (a >= 18 && a <= 23) {
        widget.list.add(10);
      } else if (a >= 14 && a <= 17) {
        widget.list.add(9);
      } else if (a >= 7 && a <= 13) {
        widget.list.add(8);
      } else if (a >= 4 && a <= 6) {
        widget.list.add(7);
      } else if (a == 3) {
        widget.list.add(6);
      } else if (a == 2) {
        widget.list.add(5);
      } else {
        widget.list.add(3);
      }
    } else {
      widget.list.add(0);
    }
  }
}
