import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mabc2/moduls/question_model.dart';
import 'package:mabc2/moduls/username_model.dart';

import '../moduls/category_model.dart';

class ApiService {
  Dio dio = Dio();
  Future<Map<String, dynamic>?> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      Response response = await dio.post(
          'https://oyinlar.pythonanywhere.com/api/token/',
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"}));
      if(response.statusCode==200){
        return response.data;
      }else{
       return {'error':'Bad request ${response.statusCode}'};
      }
    }on SocketException{
     return {'error':'Internet bilan muammo bor'};
    }
    catch (e) {
      print('Login serviceda xatolik $e');
      return {'error': 'Bunday foydalanuvchi yo\'q'};
    }
  }

  void addUser(UsernameModel usernameModel) async {
    try {
      Response response = await dio.post(
          'https://oyinlar.pythonanywhere.com/api/register/',
          data: usernameModel.toJson(),
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
    } catch (e) {
      print('addUser serviceda xatolik');
    }
  }

  Future getQuestion() async {
    try {
      Response response =
          await dio.get('https://oyinlar.pythonanywhere.com/api/categories/');
      if (response.statusCode == 200) {
        List question = response.data
            .map((e) => CategoryModel.fromJson(e))
            .toList()
            .cast<QuestionModel>();
        return question;
      }
    } catch (e) {
      print('getQuestion serviceda xatolik');
    }
  }
}
