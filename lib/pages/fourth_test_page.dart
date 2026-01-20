import 'package:flutter/material.dart';
import 'package:mabc2/pages/fifth_test_page.dart';

import '../moduls/score_model.dart';

class FourthTestPage extends StatefulWidget {
  final List list;

  const FourthTestPage({super.key, required this.list});

  @override
  State<FourthTestPage> createState() => _FourthTestPageState();
}

class _FourthTestPageState extends State<FourthTestPage> {
  final ScoreModel scoreModel = ScoreModel();
  String? selectedOption;
  final List<String> options = [
    "0-2",
    "3",
    "4",
    "5",
    "6-7",
    "8",
    "9",
    "10",
  ];

  void calculateScore(String? selection) {
    int score;
    if (selection == null) score = 0;
    switch (selection) {
      case "10":
        score = 14;
        break;
      case "9":
        score = 9;
        break;
      case "8":
        score = 8;
        break;
      case "6-7":
        score = 7;
        break;
      case "5":
        score = 6;
        break;
      case "4":
        score = 5;
        break;
      case "3":
        score = 4;
        break;
      case "0-2":
        score = 3;
        break;
      default:
        score = 0;
    }

    setState(() {
      widget.list.add(score);
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset('assets/images/game4.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Beanbagni ushlash',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '• 10 ta urinish',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Ushlab olishlar soni",
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
                      const SnackBar(
                          content: Text('Ushlab olishlar soni tanlamadi')),
                    );
                  } else {
                    calculateScore(selectedOption);
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FifthTestPage(list: widget.list),
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
