import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mabc2/pages/second_test_page.dart';

import '../moduls/score_model.dart';
class FirstTestPage extends StatefulWidget {
  final List list;
  const FirstTestPage({super.key,required this.list});

  @override
  State<FirstTestPage> createState() => _FirstTestPageState();
}

class _FirstTestPageState extends State<FirstTestPage> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool isClick=false;
  bool _isRunning = false;
  ScoreModel scoreModel=ScoreModel();

  void _toggleTimer() {
    isClick=true;
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        elevation: 10,
                        color: Colors.transparent,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset('assets/images/game1.png'),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2.w),
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
                                              value: (_elapsedSeconds % 60) / 60,
                                              strokeWidth: 5,
                                              valueColor:
                                              const AlwaysStoppedAnimation<Color>(
                                                Colors.blueAccent,
                                              ),
                                              backgroundColor: Colors.grey.shade300,
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
                      'Tangalarni joylashtirish',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Chap qo\'l bilan bajaring',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    Text(
                      '• 3-4 yoshli bolalar uchun 6 tanga',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    Text(
                      '• 5-6 yoshli bolalar uchun 12 tanga',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    Text(
                      '• Maksimal 2 ta sinov',
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
                  height: 50.h,
                  width: MediaQuery.sizeOf(context).width,
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
                  height: 50.h,
                  width: MediaQuery.sizeOf(context).width,
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
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                SecondTestPage(list: widget.list),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
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
    if(isClick){
      if (score <= 13) {
        widget.list.add(15);
      } else if (score == 14) {
        widget.list.add(14);
      } else if (score == 15) {
        widget.list.add(13);
      } else if (score == 16) {
        widget.list.add(12);
      } else if (score == 17) {
        widget.list.add(11);
      } else if (score == 18) {
        widget.list.add(10);
      } else if (score == 19) {
        widget.list.add(9);
      } else if (score == 20) {
        widget.list.add(7);
      } else if (score >= 21 && score <= 22) {
        widget.list.add(6);
      } else if (score == 23) {
        widget.list.add(5);
      } else if (score >= 24 && score <= 25) {
        widget.list.add(4);
      } else {
        widget.list.add(1);
      }
    }else{
      widget.list.add(0);
    }
  }
}