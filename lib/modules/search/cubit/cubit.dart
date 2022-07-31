import 'dart:developer';

import 'package:donations_app/models/search_model.dart';
import 'package:donations_app/modules/search/cubit/state.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitailStates());

  static SearchCubit get(context) => BlocProvider.of(context);
  List<ProjectS> projrctSM = [];

  SearchModel? model;
  int? associationId;
  List<dynamic> dataSM = [];

  
  void search(String text) {
    dataSM.length = 0;
    projrctSM.length = 0;

    emit(SearchLoadingStates());

    DioHelper.postData(
        url: 'projects/search',
        token: token,
        data: {'search': '$text'}).then((value) {
      log('${value.data['data']['association_id']}', name: "1");
      log('${value.data['data']['association_id']}', name: "2");

      List<dynamic> dataSM = value.data['data']['data'];
      // dataSM = value.data['data'];
      log('${value.data['data']['data']}', name: "dataSM");

      dataSM.forEach((element) {
        ProjectS projectsS = ProjectS.fromJson(element);
        log('${element}', name: "element");
        projrctSM.add(projectsS);
      });

      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}


// SearchModel? searchModel;
//   void getSearchData(String text){
//     emit(SearchLoadingStates());
//     DioHelper.postData(
//         url: 'projects/search',
//         token: token,
//         data: {
//            'text':text,
//         }
//     ).then((value){
//       searchModel = SearchModel.fromJson(value.data);
//       print('Search '+searchModel!.status.toString());
//       emit(SearchSuccessStates());
//     }).catchError((error){
//       emit(SearchErrorStates());
//       print(error.toString());
//     });
//   }
// }