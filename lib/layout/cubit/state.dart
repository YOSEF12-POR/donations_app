import 'package:donations_app/models/favorites/change_favorites_model.dart';
import 'package:donations_app/models/login_model/login_model.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class HomeChangeBottomNavlState extends HomeStates{}

class HomeLoadingHomeDataState extends HomeStates{}
class HomeSuccessHomeDataState extends HomeStates{}
class HomeErrorHomeDataState extends HomeStates{}

class HomeSuccessCategoriesState extends HomeStates{}
class HomeErrorCategoriesState extends HomeStates{}

class HomeChangeFavoritesState extends HomeStates{}
class HomeChangeSuccessFavoritesState extends HomeStates{
  final ChangeFavoritesModel model;

  HomeChangeSuccessFavoritesState(this.model);
}
class HomeChangeErrorFavoritesState extends HomeStates{}


class HomeLoadingGetFavoritesState extends HomeStates{}
class HomeSuccessGetFavoritesState extends HomeStates{}
class HomeErrorGetFavoritesState extends HomeStates{}

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

