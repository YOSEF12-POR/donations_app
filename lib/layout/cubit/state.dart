import 'package:donations_app/models/login_model/login_model.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class HomeChangeBottomNavlState extends HomeStates{}

class HomeLoadingHomeDataState extends HomeStates{}
class HomeSuccessHomeDataState extends HomeStates{}
class HomeErrorHomeDataState extends HomeStates{}

class HomeSuccessCategoriesState extends HomeStates{}
class HomeErrorCategoriesState extends HomeStates{}

// class HomeChangeNotificationsState extends HomeStates{}
// class HomeChangeSuccessNotificationsState extends HomeStates{
//   final ChangeNotificationsModel model;
//   HomeChangeSuccessNotificationsState(this.model);
// }
// class HomeChangeErrorNotificationsState extends HomeStates{}


// class HomeLoadingGetFavoritesState extends HomeStates{}
// class HomeSuccessGetFavoritesState extends HomeStates{}
// class HomeErrorGetFavoritesState extends HomeStates{}

class HomeLoadingUserDataState extends HomeStates{}
class HomeSuccessUserDataState extends HomeStates{
 final  LoginModel loginModel;
  HomeSuccessUserDataState(this.loginModel);
}
class HomeErrorUserDataState extends HomeStates{}


class HomeLoadingUpDateUserDataState extends HomeStates{}
class HomeSuccessUpDateUserDataState extends HomeStates{
 final  LoginModel loginModel;
  HomeSuccessUpDateUserDataState(this.loginModel);
}
class HomeErrorUpDateUserDataState extends HomeStates{}



class ProjectLoadingState extends HomeStates{}
class ProjectSuccessState extends HomeStates{}
class ProjectErrorState extends HomeStates{}


class CategoryDetailsLoadingState extends HomeStates{}
class CategoryDetailsSuccessState extends HomeStates{}
class CategoryDetailsErrorState extends HomeStates{}


class PaymentLoadingState extends HomeStates{}
class PaymentSuccessState extends HomeStates{}
class PaymentErrorState extends HomeStates{
    final String error;
  PaymentErrorState(this.error);
}

class ProfileLoadingState extends HomeStates{}
class ProfileSuccessState extends HomeStates {
  late final LoginModel loginModel;
  ProfileSuccessState (this.loginModel);
}
class ProfileErrorState extends HomeStates{}


class UserDataLoadingState extends HomeStates{}

class UserDataSuccessState extends HomeStates{
  final LoginModel?userModel;

  UserDataSuccessState(this.userModel);
}

class UserDataErrorState extends HomeStates{}





class LoadingProjectsCompState extends HomeStates{}
class SuccessProjectsCompState extends HomeStates{}
class ErrorProjectsCompState extends HomeStates{}



class LoadingNotificationsData extends HomeStates{}
class SuccessNotificationsData extends HomeStates{}
class ErrorNotificationsData extends HomeStates{}



class LoadingSendNotificationsConvert extends HomeStates{}
class SuccessSendNotificationsConvert extends HomeStates{}
class ErrorSendNotificationsConvert extends HomeStates{}


class LoadingGetBasketData extends HomeStates{}
class SuccessGetBasketData extends HomeStates{}
class ErrorGetBasketData extends HomeStates{}
