import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mabc2/pages/fourth_test_page.dart';

import '../moduls/score_model.dart';

class ThirdTestPage extends StatefulWidget {
  final List list;

  const ThirdTestPage({super.key, required this.list});

  @override
  State<ThirdTestPage> createState() => _ThirdTestPageState();
}

class _ThirdTestPageState extends State<ThirdTestPage> {
  final ScoreModel scoreModel = ScoreModel();
  String? selectedOption;
  final List<String> options = [
    "0",
    "1",
    "2",
    "3+",
  ];

  void calculateScore(String? selection) {
    int score;
    if (selection == null) score = 0;
    switch (selection) {
      case "0":
        score = 11;
        break;
      case "1":
        score = 7;
        break;
      case "2":
        score = 3;
        break;
      case "3+":
        score = 1;
        break;
      default:
        score = 0;
    }

    setState(() {
      widget.list.add(score);
      // print("Natija qo'shildi: ${widget.list}");
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
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset('assets/images/game3.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Drawing Trail',
                      style:
                          TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '• 10 ta urinish',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 16.sp),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Ko'rsatkichni tanlang",
                        border: OutlineInputBorder(),
                      ),
                      initialValue: selectedOption,
                      items: options.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
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
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tanlanmagan')),
                    );
                  } else {
                    calculateScore(selectedOption);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FourthTestPage(
                          list: widget.list,
                        ),
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Keyingi"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
