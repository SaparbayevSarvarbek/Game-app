import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  List answerList;

  ResultPage({super.key, required this.answerList});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double totalScore = 0;
  double componentScore = 0;
  double percentile = 0;
  List<double> componentList = [];
  List<double> percentileList = [];
  List<String> questionList = [
    'Tangalarni joylashtirish o\'ng qo\'lda',
    'Tangalarni joylashtirish chap qo\'lda',
    'Munchoqlarni ipga tizish',
    'Drawing Trail',
    'Beanbagni ushlash',
    'Beanbagni mat ustiga tashlash',
    'Bir oyoqli muvozanat o\'ng oyoqda',
    'Bir oyoqli muvozanat chap oyoqda',
    'Oyoq uchida yurish',
    'Matlarda sakrash',
  ];
  List<String> groupQuestionList = [
    'Tangalarni joylashtirish, Munchoqlarni ipga tizish, Drawing Trail',
    'Beanbagni ushlash, Beanbagni mat ustiga tashlash',
    'Bir oyoqli muvozanat, Oyoq uchida yurish, Matlarda sakrash',
    'Umumiy ball'
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
          padding: const EdgeInsets.all(8.0),
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
                        label: SizedBox(
                      width: 80,
                      child: Wrap(alignment: WrapAlignment.center, children: [
                        Text(
                          'Savol nomi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    )),
                    DataColumn(
                        label: SizedBox(
                      width: 80,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text('Ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )),
                  ],
                  rows: List.generate(widget.answerList.length, (index) {
                    return DataRow(cells: [
                      DataCell(Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              questionList[index],
                              maxLines: 2,
                              softWrap: true,
                            )
                          ],
                        ),
                      )),
                      DataCell(Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              '${widget.answerList[index]}',
                              maxLines: 2,
                              softWrap: true,
                            )
                          ],
                        ),
                      )),
                    ]);
                  }),
                ),
                SizedBox(height: 20),
                Text(
                  'Tangalarni joylashtirish, Munchoqlarni ipga tizish, Drawing Trail',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                DataTable(
                  columnSpacing: 10,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'Umumiy ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'O\'rtacha ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Percentile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        "${widget.answerList[0] + widget.answerList[1] + widget.answerList[2]}",
                      )),
                      DataCell(
                        Center(
                          child: Text(((componentList[0] * 10).truncate() / 10)
                              .toString()),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(((percentileList[0] * 10).truncate() / 10)
                              .toString()),
                        ),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  groupQuestionList[1],
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                DataTable(
                  columnSpacing: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'Umumiy ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'O\'rtacha ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Percentile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        SizedBox(
                          child: Wrap(
                            children: [
                              Text(
                                  "${widget.answerList[3] + widget.answerList[4] + widget.answerList[5]}")
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                                ((componentList[1] * 10).truncate() / 10)
                                    .toString())),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                                ((percentileList[1] * 10).truncate() / 10)
                                    .toString())),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  groupQuestionList[2],
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                DataTable(
                  columnSpacing: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'Umumiy ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'O\'rtacha ball',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Percentile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        SizedBox(
                          child: Wrap(
                            children: [
                              Text(
                                  "${widget.answerList[6] + widget.answerList[7] + widget.answerList[8] + widget.answerList[9]}")
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                                ((componentList[2] * 10).truncate() / 10)
                                    .toString())),
                      ),
                      DataCell(
                        Center(
                            child: Text(
                                ((percentileList[2] * 10).truncate() / 10)
                                    .toString())),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Testning umumiy natijasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DataTable(
                    columnSpacing: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                'Umumiy ball',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                'O\'rtacha ball',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                'Percentile',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        color: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                          if (totalScore <= 56) {
                            return Color.alphaBlend(
                                Colors.red.withAlpha(100), Colors.white);
                          } else if (totalScore >= 57 && totalScore <= 67) {
                            return Color.alphaBlend(
                                Colors.amber.withAlpha(100), Colors.white);
                          } else {
                            return Color.alphaBlend(
                                Colors.green.withAlpha(100), Colors.white);
                          }
                        }),
                        cells: [
                          DataCell(
                            Text(
                              "$totalScore",
                            ),
                          ),
                          DataCell(Text(((componentScore * 10).truncate() / 10)
                              .toString())),
                          DataCell(Text(
                              ((getPercentileScore(componentScore) * 10)
                                          .truncate() /
                                      10)
                                  .toString())),
                        ],
                      ),
                    ],
                  ),
                )
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
    componentList
        .add((scoreList[0] + scoreList[1] + scoreList[2] + scoreList[3]) / 4);
    componentList.add((scoreList[4] + scoreList[5]) / 2);
    componentList
        .add((scoreList[6] + scoreList[7] + scoreList[8] + scoreList[9]) / 4);
    function(componentList);
  }

  void function(List componentList) {
    double sum = 0;
    for (int i = 0; i < componentList.length; i++) {
      if (componentList[i] == 19) {
        percentileList.add(99.9);
      } else if (componentList[i] >= 18) {
        percentileList.add(99.5);
      } else if (componentList[i] >= 17) {
        percentileList.add(99);
      } else if (componentList[i] >= 16) {
        percentileList.add(98);
      } else if (componentList[i] >= 15) {
        percentileList.add(95);
      } else if (componentList[i] >= 14) {
        percentileList.add(91);
      } else if (componentList[i] >= 13) {
        percentileList.add(84);
      } else if (componentList[i] >= 12) {
        percentileList.add(75);
      } else if (componentList[i] >= 11) {
        percentileList.add(63);
      } else if (componentList[i] >= 10) {
        percentileList.add(50);
      } else if (componentList[i] >= 9) {
        percentileList.add(37);
      } else if (componentList[i] >= 8) {
        percentileList.add(25);
      } else if (componentList[i] >= 7) {
        percentileList.add(16);
      } else if (componentList[i] >= 6) {
        percentileList.add(9);
      } else if (componentList[i] >= 5) {
        percentileList.add(5);
      } else if (componentList[i] >= 4) {
        percentileList.add(2);
      } else if (componentList[i] >= 3) {
        percentileList.add(1);
      } else if (componentList[i] >= 2) {
        percentileList.add(0.5);
      } else if (componentList[i] >= 1) {
        percentileList.add(0.1);
      } else {
        percentileList.add(0);
      }
      sum += componentList[i];
    }
    print('Sum $sum \n componentScore $componentScore');
    componentScore = sum / 3;
  }

  double getPercentileScore(double a) {
    if (a == 19) {
      return 99.9;
    } else if (a >= 18) {
      return 99.5;
    } else if (a >= 17) {
      return 99;
    } else if (a >= 16) {
      return 98;
    } else if (a >= 15) {
      return 95;
    } else if (a >= 14) {
      return 91;
    } else if (a >= 13) {
      return 84;
    } else if (a >= 12) {
      return 75;
    } else if (a >= 11) {
      return 63;
    } else if (a >= 10) {
      return 50;
    } else if (a >= 9) {
      return 37;
    } else if (a >= 8) {
      return 25;
    } else if (a >= 7) {
      return 16;
    } else if (a >= 6) {
      return 9;
    } else if (a >= 5) {
      return 5;
    } else if (a >= 4) {
      return 2;
    } else if (a >= 3) {
      return 1;
    } else if (a >= 2) {
      return 0.5;
    } else if (a >= 1) {
      return 0.1;
    } else {
      return 0;
    }
  }
}
