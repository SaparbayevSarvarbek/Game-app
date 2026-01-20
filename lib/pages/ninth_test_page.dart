import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mabc2/pages/result_page.dart';

import '../moduls/score_model.dart';
class NinthTestPage extends StatefulWidget {
  final List list;
  const NinthTestPage({super.key,required this.list});

  @override
  State<NinthTestPage> createState() => _NinthTestPageState();
}

class _NinthTestPageState extends State<NinthTestPage> {
  final ScoreModel scoreModel = ScoreModel();
  String? selectedOption;
  final List<String> options = [
    "5",
    "4",
    "3",
    "0-2",
  ];

  void calculateScore(String? selection) {
    int score;
    if (selection == null) score=0;
    switch (selection) {
      case "5":
        score = 11;
        break;
      case "4":
        score = 6;
        break;
      case "3":
        score = 2;
        break;
      case "0-2":
        score = 1;
        break;
      default:
        score = 0;
    }

    setState(() {
      widget.list.add(score);
      // print("Natija qo'shildi: $score");
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        color: Colors.transparent,
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Image.asset('assets/images/game81.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Matlarda sakrash',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "To'g'ri sakrashlar soni",
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
            padding: EdgeInsets.all(16.r),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("To'g'ri sakrashlar soni tanlanmadi")),
                    );
                  } else {
                    calculateScore(selectedOption);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ResultPage(answerList: widget.list),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
