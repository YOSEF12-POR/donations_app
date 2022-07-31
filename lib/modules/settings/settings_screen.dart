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
  var formKey = GlobalKey<FormState>();
  var passwContorller = TextEditingController();
  var name;
  var email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // if (state is ProfileSuccessState) {
        //   name = state.loginModel.data!.name;
        //   email = state.loginModel.data!.email;

        //   print('${name}');
        // }
      },
      builder: (context, state) {
        // pr_name = HomeCubit.get(context).profile_name;
        // pr_email = HomeCubit.get(context).profile_email;
        // print(pr_name);

        var model = HomeCubit.get(context).loginModel;
        name = model.data!.name;
        email = model.data!.email;

        print('${name}');
        print('${email}');
        return Scaffold(
          body: state is ProfileLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : HomeCubit.get(context).bannersListH.length == 0
                      ? Center(child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset('assets/images/no.png'),
                            Text(
                              'انْتَظِرْ قَليلاً!',
                              style: TextStyle(fontSize: 45, fontFamily: 'Jannah',),
                            ),
                          ],
                        ),
                      ),
                        )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Text(
                        'الإعدادت',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      ConditionalBuilder(
                        condition: true,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'مرحباً بك ',
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${namepro}',
                                              style: TextStyle(
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'البريد الإلكتروني',
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${emailpro}',
                                              style: TextStyle(
                                                fontSize: 19,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        if (state
                                            is HomeLoadingUpDateUserDataState)
                                          LinearProgressIndicator(),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          'تغير كلمة السر ',
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 250,
                                              child: defaultFormFiled(
                                                  controller: passwContorller,
                                                  type: TextInputType.text,
                                                  validate: (value) {
                                                    if (value.isEmpty) {
                                                      return 'ادخل كلمة السر ';
                                                    }
                                                    return null;
                                                  },
                                                  label: 'كلمة السر ',
                                                  prefix: Icons.lock_outlined),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: 100,
                                              height: 50,
                                              child: defaultButton(
                                                  text: 'تغير',
                                                  function: () {
                                                    if (formKey.currentState!
                                                        .validate()) {}
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text('من نحن'),
                                          children: <Widget>[
                                            ListTile(
                                                title: Text(
                                                    '  جميعة اشرافية من قبل الوزارة الداخلية ووزارة التنمية الاجتماعية')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text('تواصل معنا '),
                                          children: <Widget>[
                                            ListTile(
                                                title: Text(
                                                    ' البريد الاليكتروني LTG@gmail.com')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 4,
                                        blurRadius: 6,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text('تعليمات الاستخدام'),
                                          children: <Widget>[
                                            ListTile(
                                                title: Text(
                                                    ' 1.تعليات الاستخدام')),
                                            ListTile(
                                                title: Text(
                                                    ' 2.تعليات الاستخدام')),
                                            ListTile(
                                                title: Text(
                                                    ' 3.تعليات الاستخدام')),
                                            ListTile(
                                                title: Text(
                                                    ' 4.تعليات الاستخدام')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                defaultButton(
                                    text: 'تسجيل خروج',
                                    function: () {
                                      signOut(context);
                                    }),
                              ],
                            ),
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}





// class SettingsScreen extends StatefulWidget {
//   @override
// }





//   // const SettingsScreen({ Key? key }) : super(key: key);
//   var formKey = GlobalKey<FormState>();

//   // var nameContorller = TextEditingController();
//   var passwContorller = TextEditingController();
//   var name ;
//   var email ; 
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeStates>(
//       listener: (context, state) {
    
//       },
//       builder: (context, state) {
//         // pr_name = HomeCubit.get(context).profile_name;
//         // pr_email = HomeCubit.get(context).profile_email;
//         // print(pr_name);
//         return Scaffold(
//           body: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Column(
//               children: [
//                 Text(
//                   'الإعدادت',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//                 ConditionalBuilder(
//                   condition: true,
//                   builder: (context) => Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'مرحباً بك ',
//                                         style: TextStyle(
//                                             fontSize: 21,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                        '${HomeCubit.get(context).profile_name}',
//                                         style: TextStyle(
//                                           fontSize: 19,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'البريد الإلكتروني',
//                                         style: TextStyle(
//                                             fontSize: 21,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                          '${HomeCubit.get(context).profile_email}',
//                                         style: TextStyle(
//                                           fontSize: 19,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   if (state is HomeLoadingUpDateUserDataState)
//                                     LinearProgressIndicator(),
//                                   SizedBox(
//                                     height: 20.0,
//                                   ),
//                                   Text(
//                                     'تغير كلمة السر ',
//                                     style: TextStyle(
//                                       fontSize: 19,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.0,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: 250,
//                                         child: defaultFormFiled(
//                                             controller: passwContorller,
//                                             type: TextInputType.text,
//                                             validate: (value) {
//                                               if (value.isEmpty) {
//                                                 return 'ادخل كلمة السر ';
//                                               }
//                                               return null;
//                                             },
//                                             label: 'كلمة السر ',
//                                             prefix: Icons.lock_outlined),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         width: 100,
//                                         height: 50,
//                                         child: defaultButton(
//                                             text: 'تغير',
//                                             function: () {
//                                               if (formKey.currentState!
//                                                   .validate()) {}
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   ExpansionTile(
//                                     title: Text('من نحن'),
//                                     children: <Widget>[
//                                       ListTile(
//                                           title: Text(
//                                               '  جميعة اشرافية من قبل الوزارة الداخلية ووزارة التنمية الاجتماعية')),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   ExpansionTile(
//                                     title: Text('تواصل معنا '),
//                                     children: <Widget>[
//                                       ListTile(
//                                           title: Text(
//                                               ' البريد الاليكتروني LTG@gmail.com')),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[50],
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(8),
//                                   topRight: Radius.circular(8),
//                                   bottomLeft: Radius.circular(8),
//                                   bottomRight: Radius.circular(8)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey[200]!,
//                                   spreadRadius: 4,
//                                   blurRadius: 6,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             width: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Column(
//                                 children: [
//                                   ExpansionTile(
//                                     title: Text('تعليمات الاستخدام'),
//                                     children: <Widget>[
//                                       ListTile(
//                                           title: Text(' 1.تعليات الاستخدام')),
//                                       ListTile(
//                                           title: Text(' 2.تعليات الاستخدام')),
//                                       ListTile(
//                                           title: Text(' 3.تعليات الاستخدام')),
//                                       ListTile(
//                                           title: Text(' 4.تعليات الاستخدام')),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           defaultButton(
//                               text: 'تسجيل خروج',
//                               function: () {
//                                 signOut(context);
//                               }),
//                         ],
//                       ),
//                     ),
//                   ),
//                   fallback: (context) =>
//                       Center(child: CircularProgressIndicator()),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

