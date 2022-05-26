import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/layout/home.dart';
import 'package:donations_app/modules/login/cubit/cubit.dart';
import 'package:donations_app/modules/login/cubit/states.dart';
import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/modules/register/cubit/cubit.dart';
import 'package:donations_app/modules/register/cubit/states.dart';
import 'package:donations_app/shared/components/ap_drawer.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
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
                        // drawer: AppDrawer(),

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
                          height: 190,
                          child: Image.asset('assets/images/logo.png'),
                        )),
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          ' Register now and contribute with us',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFiled(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'plese enter your name';
                              }
                              return null;
                            },
                            label: ' User Name',
                            prefix: Icons.person),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFiled(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'plese enter your email address';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFiled(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: RegisterCubit.get(context).suffix,
                            onSubmitt: (value) {
                              // if (formKey.currentState!.validate()) {
                              //   RegisterCubit.get(context).userLogin(
                              //       email: emailController.text,
                              //       password: passwordController.text);
                              // }
                            },
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixpressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password Error';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFiled(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'plese enter your phone';
                              }
                              return null;
                            },
                            label: 'Phone Number',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingStates,
                          builder: (context) => defaultButton(
                              text: 'REGISTER',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                }
                              }),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do you already have an account ? '),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, LoginScreen());
                                },
                                text: 'login'),
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
