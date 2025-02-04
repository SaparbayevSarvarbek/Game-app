class QuestionModel {
  int id;
  String title;
  String description;
  String image;
  String gift;
  int excellent_1;
  int excellent_2;
  int excellent_3;
  int excellent_4;
  int excellent_5;
  int excellent_6;
  int excellent_7;
  int medium_1;
  int medium_2;
  int medium_3;
  int medium_4;
  int medium_5;
  int medium_6;
  int low_pointer_1;
  int low_pointer_2;
  int low_pointer_3;
  int low_pointer_4;
  int low_pointer_5;
  int low_pointer_6;
  String create_ad;
  int toifa;

  QuestionModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.gift,
      required this.excellent_1,
      required this.excellent_2,
      required this.excellent_3,
      required this.excellent_4,
      required this.excellent_5,
      required this.excellent_6,
      required this.excellent_7,
      required this.medium_1,
      required this.medium_2,
      required this.medium_3,
      required this.medium_4,
      required this.medium_5,
      required this.medium_6,
      required this.low_pointer_1,
      required this.low_pointer_2,
      required this.low_pointer_3,
      required this.low_pointer_4,
      required this.low_pointer_5,
      required this.low_pointer_6,
      required this.create_ad,
      required this.toifa});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['Discreption'] ?? '',
      image: json['image'] ?? '',
      gift: json['gift'] ?? '',
      excellent_1: json['excellent_1'] ?? 0,
      excellent_2: json['excellent_2'] ?? 0,
      excellent_3: json['excellent_3'] ?? 0,
      excellent_4: json['excellent_4'] ?? 0,
      excellent_5: json['excellent_5'] ?? 0,
      excellent_6: json['excellent_6'] ?? 0,
      excellent_7: json['excellent_7'] ?? 0,
      medium_1: json['medium_1'] ?? 0,
      medium_2: json['medium_2'] ?? 0,
      medium_3: json['medium_3'] ?? 0,
      medium_4: json['medium_4'] ?? 0,
      medium_5: json['medium_5'] ?? 0,
      medium_6: json['medium_6'] ?? 0,
      low_pointer_1: json['low_pointer_1'] ?? 0,
      low_pointer_2: json['low_pointer_2'] ?? 0,
      low_pointer_3: json['low_pointer_3'] ?? 0,
      low_pointer_4: json['low_pointer_4'] ?? 0,
      low_pointer_5: json['low_pointer_5'] ?? 0,
      low_pointer_6: json['low_pointer_6'] ?? 0,
      create_ad: json['create_ad'] ?? 0,
      toifa: json['toifa'] ?? 0,
    );
  }
}
