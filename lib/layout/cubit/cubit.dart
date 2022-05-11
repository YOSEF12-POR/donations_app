import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/categories_model.dart';
import 'package:donations_app/models/change_favorites_model.dart';
import 'package:donations_app/models/favorites_model.dart';
import 'package:donations_app/models/home_model.dart';
import 'package:donations_app/models/login_model.dart';
import 'package:donations_app/modules/cases/cases_screen.dart';
import 'package:donations_app/modules/cateogries/cateogries_screen.dart';
import 'package:donations_app/modules/favorites/favorites_screen.dart';
import 'package:donations_app/modules/settings/settings_screen.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;



  List<Widget> bottomScreens = [
    CasesScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavlState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  // dynamic price;

  void getHomeData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);


      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      print(favorites.toString());

      emit(HomeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorHomeDataState());
    });
  }

  CategoryModel? categoryModel;

  void getGategoryData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(HomeSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int caseId) {
    favorites[caseId] = !favorites[caseId]!;
    emit(HomeChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': caseId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[caseId] = !favorites[caseId]!;
      } else {
        getFavorites();
      }
      emit(HomeChangeSuccessFavoritesState(changeFavoritesModel!));
    }).catchError((erorr) {
      favorites[caseId] = !favorites[caseId]!;

      emit(HomeChangeErrorFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
    void getFavorites() {
    emit(HomeLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(HomeSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorGetFavoritesState());
    });
  }



  LoginModel? userModel;
    void getUserData() {
    emit(HomeLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(HomeSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorUserDataState());
    });
  }
}
