import 'package:donations_app/models/search_model.dart';
import 'package:donations_app/modules/search/cubit/state.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitailStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingStates());

    DioHelper.postData(url: SEARCH,
    token: token,
     data: {'text': text}).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
    }).catchError((error) {

      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
