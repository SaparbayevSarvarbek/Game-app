import 'package:flutter/cupertino.dart';
import 'package:mabc2/moduls/result_model.dart';
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
  void pushResults(ResultModel resultModel){
    ApiService().pushResults(resultModel);
    notifyListeners();
  }

}
