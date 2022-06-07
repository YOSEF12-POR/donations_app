import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/modules/login/cubit/cubit.dart';
import 'package:donations_app/modules/login/cubit/states.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  // const SettingsScreen({ Key? key }) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameContorller = TextEditingController();
  var emailContorller = TextEditingController();
  var phoneContorller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Center(
          child: SingleChildScrollView(
            child: ConditionalBuilder(
              condition: true,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is HomeLoadingUpDateUserDataState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormFiled(
                          controller: nameContorller,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormFiled(
                          controller: emailContorller,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Email Address must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormFiled(
                          controller: phoneContorller,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20.0,
                      ),
                      // defaultButton(
                      //     text: 'Up Date',
                      //     function: () {
                      //       if (formKey.currentState!.validate()) {
                      //         HomeCubit.get(context).updateUserData(
                      //             name: nameContorller.text,
                      //             email: emailContorller.text,
                      //             phone: phoneContorller.text
                                  
                      //             );
                      //       }
                      //     }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          text: 'Logout',
                          function: () {
                            signOut(context);
                          })
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
