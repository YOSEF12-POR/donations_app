import 'package:donations_app/models/change_favorites_model.dart';

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