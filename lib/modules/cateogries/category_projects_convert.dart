import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/category/categoriesDetailsModel.dart';
import 'package:donations_app/modules/project/project_convert.dart';
import 'package:donations_app/modules/project/project_screen.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CategoryProjectsConvert extends StatelessWidget {
  final String? categoryName;
  CategoryProjectsConvert(this.categoryName);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '$categoryName',
            ),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       navigateTo(context, SearchScreen());
              //     },
              //     icon: Icon(Icons.search)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/logo11.png')),
              ),
            ],
          ),
          body: state is CategoryDetailsLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : HomeCubit.get(context).projectsList.length == 0
                  ? Center(
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(fontSize: 50),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // separator(0, 1),
                            GridView.count(
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                  HomeCubit.get(context).projectsList.length,
                                  (index) => HomeCubit.get(context)
                                              .projectsList
                                              .length ==
                                          0
                                      ? Center(
                                          child: Text(
                                            'Coming Soon',
                                            style: TextStyle(fontSize: 50),
                                          ),
                                        )
                                      : projectItemBuilder(
                                          HomeCubit.get(context)
                                              .projectsList[index],
                                          context)),
                              crossAxisSpacing: 1,
                              childAspectRatio: 1.4,
                              mainAxisSpacing: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget projectItemBuilder(Projects model, context) {
    return InkWell(
      onTap: () {
        HomeCubit.get(context).getProjectData(model.id);
        print(model.title);
        navigateTo(context, ProjectsConvert());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1),
                topRight: Radius.circular(1),
                bottomLeft: Radius.circular(1),
                bottomRight: Radius.circular(1)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[100]!,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          height: 600,
          width: 400,
          child: Container(
            height: 100,
            width: 400,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image(
                      image: NetworkImage(
                          "${baseUrlImage}${model.image_path}"),
                      width: double.infinity,
                      height: 210,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${model.title}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(6.0),
                        //       child: Row(
                        //         children: [
                        //           Text(
                        //             '${model.received_amount} من ${model.require_amount}',
                        //             textAlign: TextAlign.start,
                        //             style: TextStyle(
                        //               fontSize: 15.0,
                        //               color: Colors.black,
                        //             ),
                        //           ),
                        //           Spacer(),
                        //           Text(
                        //             '% 30 ',
                        //             textAlign: TextAlign.start,
                        //             style: TextStyle(
                        //                 fontSize: 15.0,
                        //                 color: Colors.green,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Center(
                        //       child: LinearPercentIndicator(
                        //         width: MediaQuery.of(context).size.width - 50,
                        //         animation: true,
                        //         lineHeight: 22.0,
                        //         isRTL: true,
                        //         animationDuration: 2500,
                        //         percent: 0.8,
                        //         linearStrokeCap: LinearStrokeCap.roundAll,
                        //         progressColor: defaultColor,
                        //         backgroundColor: Colors.grey[100],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
