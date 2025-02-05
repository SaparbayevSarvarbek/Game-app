import 'package:mabc2/moduls/question_model.dart';

class CategoryModel {
  String title;
  List<QuestionModel> questionList;

  CategoryModel({required this.title, required this.questionList});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    List<QuestionModel> gameList = [];
    if (json['games'] != null) {
      json['games'].forEach((key, value) {
        gameList.add(QuestionModel.fromJson(value));
      });
    }
    return CategoryModel(title: json['title'], questionList: gameList);
  }
}
