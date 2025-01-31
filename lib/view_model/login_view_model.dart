import 'package:flutter/cupertino.dart';
import 'package:mabc2/services/api_service.dart';

class LoginViewModel extends ChangeNotifier {
  void login() async {
    ApiService().login();
    notifyListeners();
  }
}
