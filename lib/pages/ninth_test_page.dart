import 'package:flutter/material.dart';
import 'package:mabc2/pages/result_page.dart';

import '../moduls/score_model.dart';
class NinthTestPage extends StatefulWidget {
  List list;
  NinthTestPage({Key? key,required this.list});

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
      print("Natija qo'shildi: $score");
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Card(
                            color: Colors.transparent,
                            elevation: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset('assets/images/game81.png'),
                            ),
                          ),
                          Card(
                            color: Colors.transparent,
                            elevation: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset('assets/images/game82.png'),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),
                  const Text(
                    'Matlarda sakrash',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "To'gri sakrashlar soni",
                      border: OutlineInputBorder(),
                    ),
                    value: selectedOption,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedOption == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('To\'g\'ri sakrashlar soni tanlamadi')),
                      );
                    }else{
                      calculateScore(selectedOption);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => ResultPage(answerList: widget.list,),
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
                      foregroundColor: Colors.white),
                  child: const Text("Keyingi"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
