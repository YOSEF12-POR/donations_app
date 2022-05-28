import 'package:donations_app/models/login_model/login_model.dart';

abstract class LoginStates{}
class  LoginInitialStates extends LoginStates{}
class  LoginLoadingStates extends LoginStates{}
class  LoginSuccessStates extends LoginStates
{
  late final LoginModel lgoinModel;
  LoginSuccessStates(this.lgoinModel);

}
class  LoginErrorStates extends LoginStates{
  final String error;
  LoginErrorStates(this.error);
  
}
class  ChangePasswordVisibilityStates extends LoginStates{}
