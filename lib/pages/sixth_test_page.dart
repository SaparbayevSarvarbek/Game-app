import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mabc2/pages/seventh_test_page.dart';

import '../moduls/score_model.dart';

class SixthTestPage extends StatefulWidget {
  final List list;

  const SixthTestPage({super.key, required this.list});

  @override
  State<SixthTestPage> createState() => _SixthTestPageState();
}

class _SixthTestPageState extends State<SixthTestPage> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  bool isClick = false;
  ScoreModel scoreModel = ScoreModel();

  void _toggleTimer() {
    isClick = true;
    setState(() {
      if (_isRunning) {
        _timer?.cancel();
        _isRunning = false;
      } else {
        _elapsedSeconds = 0; // Har safar qayta boshlashda 0 ga tushiramiz
        _isRunning = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            if (_elapsedSeconds < 30) {
              // 30 ga yetguncha sanaydi
              _elapsedSeconds++;
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
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 16.h),
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
                                width: 250.w,
                                height: 300.h,
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
                                  padding: EdgeInsets.all(8.sp),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 50.w,
                                            height: 50.h,
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
                    SizedBox(height: 16.h),
                    Text(
                      'Bir oyoqli muvozanat',
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                     Text(
                      'O\'ng oyoq bilan bajaring',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                     Text(
                      '• Maksimal vaqt 30 soniya',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                     Text(
                      '• O\'ng oyoq uchun maksimal 2 ta sinov',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.sp),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: _toggleTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_isRunning ? 'Stop' : 'Start'),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
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
                                    SeventhTestPage(list: widget.list),
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
      int a =  score;
      if (a == 30) {
        widget.list.add(13);
      } else if (a >= 28 && a <= 29) {
        widget.list.add(10);
      } else if (a >= 24 && a <= 27) {
        widget.list.add(9);
      } else if (a >= 15 && a <= 23) {
        widget.list.add(8);
      } else if (a >= 11 && a <= 14) {
        widget.list.add(7);
      } else if (a >= 7 && a <= 10) {
        widget.list.add(6);
      } else if (a == 6) {
        widget.list.add(5);
      } else if (a >= 4 && a <= 5) {
        widget.list.add(4);
      } else {
        widget.list.add(3);
      }
    } else {
      widget.list.add(0);
    }
  }
}
