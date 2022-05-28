
import 'package:donations_app/models/login_model/login_model.dart';

abstract class RegisterStates{}
class  RegisterInitialStates extends RegisterStates{}
class  RegisterLoadingStates extends RegisterStates{}
class  RegisterSuccessStates extends RegisterStates
{
  late final LoginModel lgoinModel;
  RegisterSuccessStates(this.lgoinModel);

}
class  RegisterErrorStates extends RegisterStates{
  final String error;
  RegisterErrorStates(this.error);
  
}
class  ChangeRegisterPasswordVisibilityStates extends RegisterStates{}
