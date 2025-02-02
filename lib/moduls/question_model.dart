class QuestionModel {
  int id;
  String title;
  String description;
  String image;
  String gift;
  int excellent;
  int medium;
  int low_pointer;
  String create_ad;

  QuestionModel({required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.gift,
    required this.excellent,
    required this.medium,
    required this.low_pointer,
    required this.create_ad});

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(id: json['id'] ?? 0,
        title: json['title']??'',
        description: json['Discreption']??'',
        image: json['image']??'',
        gift: json['gift']??'',
        excellent: json['excellent']??0,
        medium: json['medium']??0,
        low_pointer: json['low_pointer']??0,
        create_ad: json['create_ad']??0 );
  }
}