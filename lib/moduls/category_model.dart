import 'package:mabc2/moduls/question_model.dart';

class CategoryModel {
  String title;
  List<QuestionModel> questionList;

  CategoryModel({required this.title, required this.questionList});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'],
      questionList: (json['game'] as List)
          .map((game) => QuestionModel.fromJson(game))
          .toList(),
    );
  }
}