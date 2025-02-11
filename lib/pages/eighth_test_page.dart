import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/pages/ninth_test_page.dart';
import 'package:mabc2/pages/second_test_page.dart';

import '../moduls/score_model.dart';

class EighthTestPage extends StatefulWidget {
  const EighthTestPage({super.key});

  @override
  State<EighthTestPage> createState() => _EighthTestPageState();
}

class _EighthTestPageState extends State<EighthTestPage> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  ScoreModel scoreModel = ScoreModel();

  void _toggleTimer() {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                            child: Container(
                              width: 250,
                              height: 300,
                              child: Image.asset(
                                'assets/images/game7.png',
                              ),
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
                    'Oyoq uchida yurish',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '• 4,5 m chiziq',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    '• Maksimal ball 15 qadam yoki bola qator oxiriga yetib borganda',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: _toggleTimer,
                      child: Text(_isRunning ? 'Stop' : 'Start'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRunning ? Colors.red : Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
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
                                      NinthTestPage(),
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
          ),
        ],
      ),
    );
  }

  void calculateScore(int score) {
    if (score <= 13) {
      scoreModel.results.add(15);
    } else if (score == 14) {
      scoreModel.results.add(14);
    } else if (score == 15) {
      scoreModel.results.add(13);
    } else if (score == 16) {
      scoreModel.results.add(12);
    } else if (score == 17) {
      scoreModel.results.add(11);
    } else if (score == 18) {
      scoreModel.results.add(10);
    } else if (score == 19) {
      scoreModel.results.add(9);
    } else if (score == 20) {
      scoreModel.results.add(7);
    } else if (score >= 21 && score <= 22) {
      scoreModel.results.add(6);
    } else if (score == 23) {
      scoreModel.results.add(5);
    } else if (score >= 24 && score <= 25) {
      scoreModel.results.add(4);
    } else {
      scoreModel.results.add(1);
    }
  }
}
