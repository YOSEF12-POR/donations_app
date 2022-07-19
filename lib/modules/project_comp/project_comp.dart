import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/home_model/home_model.dart';
import 'package:donations_app/models/projectcomp_mode/projectcomp_model.dart';
import 'package:donations_app/modules/project/project_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectComp extends StatelessWidget {
  const ProjectComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  المشاريع المكتملة  ',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: PageScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildProjectsC(
                            HomeCubit.get(context).projectcList[index],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount:
                            HomeCubit.get(context).projectcList.length,
                      ),
                    ),
                      SizedBox(
                      height: 20.0,
                    ),
                     Text(
                      ' المشاريع المكتملة جزئياً',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 450,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: PageScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildProjectsP(
                            HomeCubit.get(context).projectpList[index],
                            context),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                        itemCount:
                            HomeCubit.get(context).projectpList.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget buildProjectsC(ProjectsCModel model, context) => InkWell(
      // onTap: () {
      //   HomeCubit.get(context).getProjectData(model.id);
      //   print(model.title);
      //   navigateTo(context, ProjectsDetails());
      // },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        height: 600,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 400,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: NetworkImage("${baseUrlImage}${model.image_path}"),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 28,
                          animation: true,
                          lineHeight: 22.0,
                          isRTL: true,
                          animationDuration: 2500,
                          percent: model.received_amount / model.require_amount,
                          center: Text(
                            '${(model.received_amount / model.require_amount * 100).round()} % ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: defaultColor,
                          backgroundColor: Colors.grey[100],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12.0, right: 12.0, bottom: 2.0),
                        child: Row(
                          children: [
                            Container(
                              width: 300,
                              child: Text(
                                '${model.title}',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showToast(
                                      text: 'التفاصيل',
                                      state: ToastStates.WARNING);
                                },
                                icon: Icon(Icons.info_outline_rounded)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12.0, right: 12.0, bottom: 2.0),
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('تم الجمع '),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${model.received_amount}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: defaultColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            // Container(
                            //   width: 130,
                            //   height: 50,
                            //   child: defaultFormFiled(
                            //       controller: amountController,
                            //       type: TextInputType.number,
                            //       validate: (value) {
                            //         if (value.isEmpty) {
                            //           return 'ادخل المبلغ المراد التبرع به ';
                            //         }
                            //         return null;
                            //       },
                            //       label: 'المبلغ',
                            //       prefix: Icons.email),
                            // ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('المبلغ المتبقي'),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${model.require_amount - model.received_amount}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: defaultColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showToast(
                                  text: 'مشاركة', state: ToastStates.WARNING);
                            },
                            icon: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.share_sharp,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // HomeCubit.get(context).changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 30.0,
                              // backgroundColor:
                              //     HomeCubit.get(context).favorites[model.id]!
                              //         ? defaultColor
                              //         : Colors.grey,
                              child: Icon(
                                Icons.wallet_giftcard_rounded,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


    Widget buildProjectsP(ProjectsPModel model, context) => InkWell(
      // onTap: () {
      //   HomeCubit.get(context).getProjectData(model.id);
      //   print(model.title);
      //   navigateTo(context, ProjectsDetails());
      // },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
        height: 600,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: 400,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: NetworkImage("${baseUrlImage}${model.image_path}"),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 28,
                          animation: true,
                          lineHeight: 22.0,
                          isRTL: true,
                          animationDuration: 2500,
                          percent: model.received_amount / model.require_amount,
                          center: Text(
                            '${(model.received_amount / model.require_amount * 100).round()} % ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: defaultColor,
                          backgroundColor: Colors.grey[100],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12.0, right: 12.0, bottom: 2.0),
                        child: Row(
                          children: [
                            Container(
                              width: 300,
                              child: Text(
                                '${model.title}',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 19.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showToast(
                                      text: 'التفاصيل',
                                      state: ToastStates.WARNING);
                                },
                                icon: Icon(Icons.info_outline_rounded)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 12.0, right: 12.0, bottom: 2.0),
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('تم الجمع '),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${model.received_amount}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: defaultColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            // Container(
                            //   width: 130,
                            //   height: 50,
                            //   child: defaultFormFiled(
                            //       controller: amountController,
                            //       type: TextInputType.number,
                            //       validate: (value) {
                            //         if (value.isEmpty) {
                            //           return 'ادخل المبلغ المراد التبرع به ';
                            //         }
                            //         return null;
                            //       },
                            //       label: 'المبلغ',
                            //       prefix: Icons.email),
                            // ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text('المبلغ المتبقي'),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${model.require_amount - model.received_amount}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14.0, color: defaultColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showToast(
                                  text: 'مشاركة', state: ToastStates.WARNING);
                            },
                            icon: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.share_sharp,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // HomeCubit.get(context).changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 30.0,
                              // backgroundColor:
                              //     HomeCubit.get(context).favorites[model.id]!
                              //         ? defaultColor
                              //         : Colors.grey,
                              child: Icon(
                                Icons.wallet_giftcard_rounded,
                                size: 22.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

