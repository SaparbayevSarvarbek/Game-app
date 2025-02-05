import 'package:flutter/cupertino.dart';
import 'package:mabc2/services/api_service.dart';

class TestViewModel extends ChangeNotifier {
  List question=[];
  bool isLoading=false;
  Future getQuestion() async {
    isLoading=true;
    notifyListeners();
    try{
      question=await ApiService().getQuestion();
    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
  Future logOut(String refreshToken)async{
    ApiService().logOut(refreshToken);
    notifyListeners();
  }
}
