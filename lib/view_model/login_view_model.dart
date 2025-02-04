import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mabc2/pages/home_page.dart';
import 'package:mabc2/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? errorMessage;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginUser(String username, String password, BuildContext context) async {
    setLoading(true);
    final response = await _apiService.login(username, password);
    setLoading(false);

    if (response != null) {
      if (response.containsKey('refresh')) {
        String token = response['access'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kirish muvaffaqiyatli!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
      else {
        errorMessage = response['error'] ?? 'Bunday foydalanuvchi yo\'q';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tarmoq xatoligi yuz berdi')),
      );
    }
  }
}