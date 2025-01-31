import 'dart:io';

import 'package:dio/dio.dart';
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
}
