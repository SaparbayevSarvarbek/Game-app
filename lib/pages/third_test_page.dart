import 'package:flutter/material.dart';

import '../moduls/score_model.dart';
class ThirdTestPage extends StatefulWidget {
  const ThirdTestPage({super.key});

  @override
  State<ThirdTestPage> createState() => _ThirdTestPageState();
}

class _ThirdTestPageState extends State<ThirdTestPage> {
  final ScoreModel scoreModel = ScoreModel();
  String? selectedOption;
  final List<String> options = [
    "13 soniya yoki kamroq",
    "14 soniya",
    "15 soniya",
    "16 soniya",
    "17 soniya",
    "18 soniya",
    "19 soniya",
    "20 soniya",
    "21-22 soniya",
    "23 soniya",
    "24-25 soniya",
    "26 yoki undan ko'p"
  ];

  void calculateScore(String? selection) {
    if (selection == null) return;

    int score;
    switch (selection) {
      case "13 soniya yoki kamroq":
        score = 15;
        break;
      case "14 soniya":
        score = 14;
        break;
      case "15 soniya":
        score = 13;
        break;
      case "16 soniya":
        score = 12;
        break;
      case "17 soniya":
        score = 11;
        break;
      case "18 soniya":
        score = 10;
        break;
      case "19 soniya":
        score = 9;
        break;
      case "20 soniya":
        score = 7;
        break;
      case "21-22 soniya":
        score = 6;
        break;
      case "23 soniya":
        score = 5;
        break;
      case "24-25 soniya":
        score = 4;
        break;
      default:
        score = 1;
    }

    setState(() {
      scoreModel.results.add(score);
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Card(
                      elevation: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset('assets/images/game4.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tangalarni joylashtirish',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '• 3-4 yoshli bolalar uchun 6 tanga',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    '• 5-6 yoshli bolalar uchun 12 tanga',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Vaqtni tanlang",
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
                      calculateScore(value);
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
                    print("Saqlangan natijalar: ${scoreModel.results}");
                  },
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