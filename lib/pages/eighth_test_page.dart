import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mabc2/pages/ninth_test_page.dart';

import '../moduls/score_model.dart';

class EighthTestPage extends StatefulWidget {
  List list;

  EighthTestPage({Key? key, required this.list}) : super(key: key);

  @override
  State<EighthTestPage> createState() => _EighthTestPageState();
}

class _EighthTestPageState extends State<EighthTestPage> {
  final ScoreModel scoreModel = ScoreModel();
  String? selectedOption;
  final List<String> options = [
    "15",
    "14",
    "13",
    "11-12",
    "9-10",
    "6-8",
    "0-5",
  ];

  void calculateScore(String? selection) {
    int score;
    if (selection == null) score=0;
    switch (selection) {
      case "15":
        score = 11;
        break;
      case "14":
        score = 10;
        break;
      case "13":
        score = 8;
        break;
      case "11-12":
        score = 6;
        break;
      case "9-10":
        score = 5;
        break;
      case "6-8":
        score = 4;
        break;
      case "0-5":
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Card(
                        color: Colors.transparent,
                        elevation: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset('assets/images/game7.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Oyoq uchida yurish',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text('• 4,5 m chiziq', style: TextStyle(fontSize: 18)),
                    const Text('• Maksimal 2 ta sinov', style: TextStyle(fontSize: 18)),
                    const Text(
                      '• Maksimal ball 15 qadam yoki bola qator oxiriga yetib borganda',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Qadamlar soni",
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
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Qadamlar soni tanlang')),
                    );
                  } else {
                    calculateScore(selectedOption);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            NinthTestPage(list: widget.list),
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