class ResultModel {
  String allResult;
  List<int> results;
  int userId;

  ResultModel(
      {required this.allResult, required this.results, required this.userId});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
        allResult: json['result'] ?? '',
        results: json['resultlar'] ?? 0,
        userId: json['user'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'result': allResult, 'resultlar': results, 'user': userId};
  }
}
