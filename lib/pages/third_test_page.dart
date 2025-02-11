import 'package:flutter/material.dart';
import 'package:mabc2/pages/fourth_test_page.dart';

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
    if (selection == null) return;

    int score;
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
                        child: Image.asset('assets/images/game3.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Drawing Trail',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '• 10 ta urinish',
                    style: TextStyle(fontSize: 18,),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Ko'rsatkichni tanlang",
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
                    if(selectedOption==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tanlanmagan')),
                      );
                    }else{
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => FourthTestPage(),
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
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo,foregroundColor: Colors.white
                  ),
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