import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  List answerList;

  ResultPage({super.key, required this.answerList});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double totalScore = 0;
  List<double> componentList = [];
  List<String> questionList = [
    'Posting Coins',
    'Posting Coins',
    'Threading Beads',
    'Drawing Trail Age Band 1',
    'Catching Beanbag',
    'Throwing Beanbag onto Mat',
    'One-Leg Balance',
    'One-Leg Balance',
    'Walking Heels Raised',
    'Jumping on Mats',
  ];
  List<String> groupQuestionList=[
    'Posting Coins left, Posting Coins right,Threading Beads,Drawing Trail Age Band 1',
    'Catching Beanbag,Throwing Beanbag onto Mat',
    'One-Leg Balance right,One-Leg Balance left,Walking Heels Raised,Jumping on Mats',
    'Total score'
  ];

  @override
  void initState() {
    super.initState();
    checkScore(widget.answerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Natija'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: [
                    DataColumn(
                        label: Text('Savol Nomlari',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Ball',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(widget.answerList.length, (index) {
                    return DataRow(cells: [
                      DataCell(Text(questionList[index])),
                      DataCell(Text('${widget.answerList[index]}')),
                    ]);
                  }),
                ),
                SizedBox(height: 20),
                DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: [
                    DataColumn(
                        label: Text('Savol Nomlari',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Ball',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(groupQuestionList.length, (index) {
                    return DataRow(cells: [
                      DataCell(Text(groupQuestionList[index])),
                      DataCell(Text('${componentList[index]}')),
                    ]);
                  }),
                ),
                Text(
                  'Umumiy Ball: $totalScore',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkScore(List scoreList) {
    if (scoreList.length < 10) {
      return;
    }
    totalScore = scoreList.fold(0, (sum, item) => sum + item);
    double item = (scoreList[0] + scoreList[1]) / 2;
    componentList.add((item + scoreList[2] + scoreList[3]) / 3);
    componentList.add((scoreList[4] + scoreList[5]) / 2);
    double item1 = (scoreList[6] + scoreList[7]) / 2;
    componentList.add((item1 + scoreList[8] + scoreList[9]) / 3);
    componentList.add(totalScore / 10);
  }
}
