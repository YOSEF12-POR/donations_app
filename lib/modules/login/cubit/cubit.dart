import 'package:bloc/bloc.dart';
import 'package:donations_app/models/login_model.dart';
import 'package:donations_app/modules/login/cubit/states.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());
  static LoginCubit get(context) => BlocProvider.of(context);

    late LoginModel  lgoinModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      lgoinModel= LoginModel.fromJson(value.data);
      emit(LoginSuccessStates(lgoinModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityStates());
  }
}
