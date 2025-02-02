import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mabc2/moduls/question_model.dart';
import 'package:mabc2/moduls/username_model.dart';

class ApiService {
  Dio dio = Dio();

  void login() async {
    try{
      Response response=await dio.post('https://oyinlar.pythonanywhere.com/api/login/',
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
    }catch(e){
      print('Login serviceda xatolik');
    }
  }
  
  void addUser(UsernameModel usernameModel) async{
    try{
      Response response=await dio.post('https://oyinlar.pythonanywhere.com/api/register/',data: usernameModel.toJson(),
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }
      ));
    }catch(e){
      print('addUser serviceda xatolik');
    }
  }
  Future getQuestion() async{
    try{
      Response response=await dio.get('https://oyinlar.pythonanywhere.com/api/evaluations/');
      if(response.statusCode==200){
        List question=response.data.map((e)=>QuestionModel.fromJson(e)).toList().cast<QuestionModel>();
        return question;
      }
    }catch(e){
      print('getQuestion serviceda xatolik');
    }
  }
}
