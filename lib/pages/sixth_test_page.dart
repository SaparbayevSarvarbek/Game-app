import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/pages/seventh_test_page.dart';

import '../moduls/score_model.dart';

class SixthTestPage extends StatefulWidget {
  const SixthTestPage({super.key});

  @override
  State<SixthTestPage> createState() => _SixthTestPageState();
}

class _SixthTestPageState extends State<SixthTestPage> {
  Timer? _timer;
  int _elapsedSeconds = 30;
  bool _isRunning = false;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                                'assets/images/game6.png',
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
                                border: Border.all(
                                    color: Colors.white, width: 2),
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
                    'Bir oyoqli muvozanat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'O\'ng oyoq bilan bajaring',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    '• Maksimal vaqt 30 soniya',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    '• O\'ng oyoq uchun maksimal 2 ta sinov',
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ElevatedButton(
                      onPressed: _toggleTimer,
                      child: Text(_isRunning ? 'Stop' : 'Start'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _isRunning ? Colors.red : Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_isRunning) {
                            _timer?.cancel();
                            _isRunning = false;
                          }
                          //calculateScore(_elapsedSeconds);
                          print("Vaqt qo‘shildi: ${scoreModel.results}s");
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  SeventhTestPage(),
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
}