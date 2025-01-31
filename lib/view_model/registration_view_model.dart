import 'package:mabc2/moduls/username_model.dart';
import 'package:mabc2/services/api_service.dart';

class RegistrationViewModel{
  void addUser(UsernameModel usernameModel) async{
    ApiService().addUser(usernameModel);
  }
}