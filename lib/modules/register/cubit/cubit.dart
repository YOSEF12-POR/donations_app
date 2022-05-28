import 'package:donations_app/models/login_model/login_model.dart';
import 'package:donations_app/modules/register/cubit/states.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel lgoinModel;
  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(RegisterLoadingStates());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      print(value.data);
      lgoinModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessStates(lgoinModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangeRegisterPasswordVisibilityStates());
  }
}
