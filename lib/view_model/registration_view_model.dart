import 'package:flutter/material.dart';
import 'package:mabc2/moduls/username_model.dart';
import 'package:mabc2/services/api_service.dart';

class RegistrationViewModel extends ChangeNotifier{
  void addUser(UsernameModel usernameModel) async{
    ApiService().addUser(usernameModel);
    notifyListeners();
  }
}