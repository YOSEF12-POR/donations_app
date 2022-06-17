import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/home.dart';
import 'package:donations_app/modules/login/cubit/cubit.dart';
import 'package:donations_app/modules/login/cubit/states.dart';
import 'package:donations_app/modules/register/register_screen.dart';
import 'package:donations_app/shared/components/ap_drawer.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var device_nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessStates) {
            if (state.lgoinModel.status!) {
              print(state.lgoinModel.message);
              print(state.lgoinModel.data!.token);

              CacheHelper.saveData(
                      key: 'token', value: state.lgoinModel.data!.token)
                  .then((value) {
                token = state.lgoinModel.data!.token;
                navigateAndFinish(context, HomeLayout());
              });
              showToast(
                  text: state.lgoinModel.message!, state: ToastStates.SUCCESS);
            } else {
              print(state.lgoinModel.message);
              showToast(
                  text: state.lgoinModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                  height: 250,
                  child: Image.asset('assets/images/logo11.png'),
                ),
                        ),
                        Text(
                          'تسجيل الدخول',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'سجل الدخول الآن وساهم معنا',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFiled(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'الرجاء إدخال عنوان البريد الإلكتروني الخاص بك';
                              }
                              return null;
                            },
                            label: 'البريد الالكترونى',
                            prefix: Icons.email),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormFiled(
                            controller: device_nameController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'plese enter your device_name';
                              }
                              return null;
                            },
                            label: 'device_name',
                            prefix: Icons.nat),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFiled(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: LoginCubit.get(context).suffix,
                            onSubmitt: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    device_name: device_nameController.text,
                                    
                                    );
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixpressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'خطأ في كلمة المرور';
                              }
                              return null;
                            },
                            label: 'كلمة المرور',
                            prefix: Icons.lock_outlined),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingStates,
                          builder: (context) => defaultButton(
                              text: 'تسجيل الدخول',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      device_name: device_nameController.text,
                                      
                                      );
                                }
                              }
                              ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ليس لديك حساب ؟ '),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'سجل الان'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
