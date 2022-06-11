import 'dart:developer';

import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/category/categoriesDetailsModel.dart';
// as category;
import 'package:donations_app/models/category/categories_model.dart';
import 'package:donations_app/models/home_model/projects_model.dart';

import 'package:donations_app/models/home_model/home_model.dart';
import 'package:donations_app/models/login_model/login_model.dart';
import 'package:donations_app/modules/account/account_screen.dart';
import 'package:donations_app/modules/home_screen.dart';
import 'package:donations_app/modules/cateogries/cateogries_screen.dart';
import 'package:donations_app/modules/settings/settings_screen.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  CategoryDetailModel? categoriesDetailModel;
  ProjectsDetailsModel? casesDetailsModel;
  CategoryModel? categoryModel;

  int currentIndex = 0;
  String? name;

  List<ProjectsModel> projectsListH = [];
  List<BannerModel> bannersListH = [];
  List<Projects> projectsList = [];
  List<dynamic> data = [];

  int? count_project = 0;
  int? sum_received_amount = 0;
  int? sum_num_beneficiaries = 0;

  List<Widget> bottomScreens = [
    HomeScreen(),
    CateogriesScreen(),
    AccountScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavlState());
  }

  void getHomeData() {
    emit(HomeLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      count_project = value.data['data']['count_project'];
      sum_received_amount = value.data['data']['sum_received_amount'];
      sum_num_beneficiaries = value.data['data']['sum_num_beneficiaries'];

      List<dynamic> dataHome = value.data['data']['projects'];

      dataHome.forEach((element) {
        ProjectsModel projectsHome = ProjectsModel.fromJson(element);
        projectsListH.add(projectsHome);
      });

      List<dynamic> dataHomeBanner = value.data['data']['banners'];
      dataHomeBanner.forEach((element) {
        BannerModel bannerModel = BannerModel.fromJson(element);
        log('${element}', name: "element");
        bannersListH.add(bannerModel);
      });

      emit(HomeSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorHomeDataState());
    });
  }

  List<ProjectCategoryM> projrctCM = [];
  List<dynamic> dataPM = [];
  List<ProjectAssociationM> projrctAM = [];
  List<dynamic> dataPA = [];
  String? titleP;
  String? descriptionP;
  int? requireAmountP;
  int? receivedAmountP;
  String? image_pathP;

  void getProjectData(int? id) {
    emit(ProjectLoadingState());
    DioHelper.getData(url: 'projects/$id', token: token).then((value) {
      projrctCM.length = 0;
      dataPM.length = 0;
      projrctAM.length = 0;
      dataPA.length = 0;
      titleP = '';
      descriptionP = '';
      requireAmountP = 0;
      receivedAmountP = 0;
      image_pathP = '';
      log('${value.data['data']['duration_unit']}', name: "1");

      dataPM = value.data['data']['category'];
      dataPA = value.data['data']['association'];
      titleP = value.data['data']['title'];
       image_pathP = value.data['data']['image_path'];

        log('${image_pathP}', name: "image_pathP");
        log('${titleP}', name: "titleP");

      descriptionP = value.data['data']['description'];
      requireAmountP = value.data['data']['require_amount'];
      receivedAmountP = value.data['data']['received_amount'];
      dataPM.forEach((element) {
        ProjectCategoryM projectCategoryM = ProjectCategoryM.fromJson(element);
        log('${element}', name: "element");
        projrctCM.add(projectCategoryM);
      });

      dataPA.forEach((element) {
        ProjectAssociationM projectAssociationM =
            ProjectAssociationM.fromJson(element);
        log('${element}', name: "element");
        projrctAM.add(projectAssociationM);
      });

      emit(ProjectSuccessState());
    }).catchError((error) {
      emit(ProjectErrorState());
      print(error.toString());
    });
  }

  void getCategoriesDetailData(int? categoryID) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
      url: 'categories/$categoryID',
    ).then((value) {
      projectsList.length = 0;
      data.length = 0;

      data = value.data['data'];
      data.forEach((element) {
        Projects project = Projects.fromJson(element);
        projectsList.add(project);
      });

      emit(CategoryDetailsSuccessState());
    }).catchError((error) {
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

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
}
