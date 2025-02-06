import 'package:flutter/material.dart';
class ResultPage extends StatefulWidget {
  List timeList;
  List questionList;
  ResultPage({super.key, required this.timeList,required this.questionList});
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int totalScore=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Natija'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Chiziqlarni ko'rsatish
                borderRadius: BorderRadius.circular(8), // Burchaklarni yumshatish
              ),
              columns: [
                DataColumn(label: Text('Savol Nomlari', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Vaqt (s)', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Ball', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List.generate(widget.timeList.length, (index) {
                return DataRow(cells: [
                  DataCell(Text(widget.questionList[index].title)),
                  DataCell(Text('${widget.timeList[index]} s')),
                  DataCell(Text('10')),
                ]);
              }),
            ),
            SizedBox(height: 20),
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
    );
  }
}
