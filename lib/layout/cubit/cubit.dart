import 'dart:developer';

import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/basket/basket_model.dart';
import 'package:donations_app/models/category/categoriesDetailsModel.dart';
// as category;
import 'package:donations_app/models/category/categories_model.dart';
import 'package:donations_app/models/home_model/projects_model.dart';

import 'package:donations_app/models/home_model/home_model.dart';
import 'package:donations_app/models/login_model/login_model.dart';
import 'package:donations_app/models/profile_model/profile_model.dart';
import 'package:donations_app/models/projectcomp_mode/projectcomp_model.dart';
import 'package:donations_app/modules/basket/basket_screen.dart';
import 'package:donations_app/modules/home_screen.dart';
import 'package:donations_app/modules/cateogries/cateogries_screen.dart';
import 'package:donations_app/modules/project_comp/project_comp.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/modules/settings/settings_screen.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'package:sqflite/sql.dart';

import '../../models/notifications_model/notifications_model.dart';

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
  List<ImagesModel> imagesmodelP = [];

  List<Projects> projectsList = [];
  List<dynamic> data = [];

  int? count_project = 0;
  int? sum_received_amount = 0;
  int? sum_num_beneficiaries = 0;

  String? profile_name = '';
  String? profile_email = '';
  String? old_password = '';

  List<Widget> bottomScreens = [
    HomeScreen(),
    CateogriesScreen(),
    ProjectComp(),
    BasketScreen(),
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
      count_project = value.data['data']['count_project_open'];
      sum_received_amount = value.data['data']['count_project_completed'];
      sum_num_beneficiaries = value.data['data']['sum_received_amount'];
      number = count_project;
      List<dynamic> dataHome = value.data['data']['projects'];
      dataHome.forEach((element) {
        ProjectsModel projectsHome = ProjectsModel.fromJson(element);

        projectsListH.add(projectsHome);
      });

      List<dynamic> dataHomeBanner = value.data['data']['banners'];
      dataHomeBanner.forEach((element) {
        BannerModel bannerModel = BannerModel.fromJson(element);
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
  int? idP;

  void getProjectData(int? id) {
    emit(ProjectLoadingState());
    DioHelper.getData(url: 'projects/$id', token: token).then((value) {
      projrctCM.length = 0;
      dataPM.length = 0;
      projrctAM.length = 0;
      dataPA.length = 0;
      titleP = '';
      idP = 0;

      descriptionP = '';
      requireAmountP = 0;
      receivedAmountP = 0;
      image_pathP = '';

      dataPM = value.data['data']['category'];
      dataPA = value.data['data']['association'];
      titleP = value.data['data']['title'];
      image_pathP = value.data['data']['image_path'];
      descriptionP = value.data['data']['description'];
      requireAmountP = value.data['data']['require_amount'];
      receivedAmountP = value.data['data']['received_amount'];
      idP = value.data['data']['id'];

      dataPM.forEach((element) {
        ProjectCategoryM projectCategoryM = ProjectCategoryM.fromJson(element);
        projrctCM.add(projectCategoryM);
      });

      List<dynamic> imagesmodell = value.data['data']['projects_paths'];
      imagesmodell.forEach((element) {
        ImagesModel imagesModel = ImagesModel.fromJson(element);
        imagesmodelP.add(imagesModel);
      });

      dataPA.forEach((element) {
        ProjectAssociationM projectAssociationM =
            ProjectAssociationM.fromJson(element);
        // log('${element}', name: "element");
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

  // NotificationsDetailModel? notificationsDetailModel;

  List<Notifications> notificaytionsList = [];
  List<dynamic> dataN = [];
  void getNotificationsData() {
    emit(LoadingNotificationsData());
    DioHelper.getData(
      url: 'notifications',
      token: token,
    ).then((value) {
      notificaytionsList.length = 0;
      dataN.length = 0;

      dataN = value.data['data'];
      dataN.forEach((element) {
        Notifications notifications = Notifications.fromJson(element);
        // log('${notifications}', name: "notifications");

        notificaytionsList.add(notifications);
      });
      emit(SuccessNotificationsData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorNotificationsData());
    });
  }

// class LoadingGetBasketData extends HomeStates{}
// class SuccessGetBasketData extends HomeStates{}
// class ErrorGetBasketData extends HomeStates{}

List<BasketsData> basketList = [];
  List<dynamic> dataB = [];
      int? count_basket;

  void getBasketData() {
    emit(LoadingGetBasketData());
    DioHelper.getData(
      url: 'basket',
      token: token,
    ).then((value) {
      basketList.length = 0;
      dataB.length = 0;
      count_basket = 0;
      count_basket = value.data['count_basket'];

      dataB = value.data['basket'];
      dataB.forEach((element) {
        BasketsData basketsData = BasketsData.fromJson(element);
        log('${element}', name: "basketsData");
        // log('${count_basket}', name: "count_basket");

        basketList.add(basketsData);
      });
      emit(SuccessGetBasketData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetBasketData());
    });
  }





















  late LoginModel loginModel;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      profile_name = '';
      profile_email = '';
      old_password = '';

      profile_name = value.data['data']['name'];
      profile_email = value.data['data']['email'];
      old_password = value.data['data']['password'];

      log('${profile_name}', name: "name");
      log('${profile_email}', name: "email");
      log('${old_password}', name: "password");

      loginModel = LoginModel.fromJson(value.data);
// log('${loginModel.data!.name}', name: "name");

      emit(ProfileSuccessState(loginModel));
    }).catchError((error) {
      emit(ProfileErrorState());
      print(error.toString());
    });
  }

  List<ProjectsCModel> projectcList = [];
  List<ProjectsPModel> projectpList = [];

  void getProjectsCompData() {
    emit(LoadingProjectsCompState());
    DioHelper.getData(
      url: 'completed',
      token: token,
    ).then((value) {
      List<dynamic> dataprojectc = value.data['data']['projects_completed'];
      dataprojectc.forEach((element) {
        ProjectsCModel projectsCModel = ProjectsCModel.fromJson(element);
        // log('${element}', name: "element0");

        projectcList.add(projectsCModel);
      });

      List<dynamic> dataprojectp =
          value.data['data']['projects_completed_partial'];
      dataprojectp.forEach((element) {
        ProjectsPModel projectsPModel = ProjectsPModel.fromJson(element);

        // log('${element}', name: "element2");

        projectpList.add(projectsPModel);
      });

      emit(SuccessProjectsCompState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorProjectsCompState());
    });
  }

  void sendNotofictionsConvert(
      int  id_notification, 
      int previous_project_id, int new_project_id
      ) {
    emit(LoadingSendNotificationsConvert());

    DioHelper.postData(url:'update_status', token: token, data: {
      'id_notification': id_notification,
      'previous_project_id': previous_project_id ,
      'new_project_id': new_project_id ,
    }).then((value) {

      // print('${id_notification}');
      
      emit(SuccessSendNotificationsConvert());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSendNotificationsConvert());
    });
  }
}
