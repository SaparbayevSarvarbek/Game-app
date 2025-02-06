import 'package:flutter/material.dart';
import 'package:mabc2/moduls/result_model.dart';
import 'package:mabc2/view_model/test_view_model.dart';
import 'package:provider/provider.dart';
class ResultPage extends StatefulWidget {
  List timeList;
  List questionList;
  ResultPage({super.key, required this.timeList,required this.questionList});
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int totalScore=0;
  List<int> scoreList=[];
@override
  void initState() {
    super.initState();
    checkScore(widget.timeList);
    context.read<TestViewModel>().pushResults(ResultModel(allResult: totalScore.toString(), results: scoreList, userId: 1));
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Natija'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DataTable(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              columns: [
                DataColumn(label: Text('Savol Nomlari', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Ball', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Vaqt (s)', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List.generate(widget.timeList.length, (index) {
                return DataRow(cells: [
                  DataCell(Text(widget.questionList[index].title)),
                  DataCell(Text('${scoreList[index]}')),
                  DataCell(Text('${widget.timeList[index]} s')),
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
  void checkScore(List timeList) {
    for(int i=0;i<timeList.length;i++){
      if(timeList[i]<=9){
        scoreList.add(16);
      }else if(timeList[i]<=10){
        scoreList.add(14);
      }else if(timeList[i]<=11){
        scoreList.add(13);
      }else if(timeList[i]<=12){
        scoreList.add(12);
      }else if(timeList[i]<=13){
        scoreList.add(11);
      }else if(timeList[i]<=14){
        scoreList.add(10);
      }else if(timeList[i]<=15){
        scoreList.add(9);
      }else if(timeList[i]<=16){
        scoreList.add(8);
      }else if(timeList[i]<=17){
        scoreList.add(6);
      }else if(timeList[i]<=18){
        scoreList.add(4);
      }else{
        scoreList.add(1);
      }
      totalScore=totalScore+scoreList[i];
    }

  }
}