import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/home_model/projects_model.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectsDetails extends StatefulWidget {
  @override
  State<ProjectsDetails> createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {
  bool islast = false;
  var Pagecontrolar = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is ProjectLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : HomeCubit.get(context).projrctCM.length == 0 &&
                      HomeCubit.get(context).projrctAM.length == 0
                  ? Center(
                      child: Text(
                        'انْتَظِرْ قَليلاً',
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
                              physics: BouncingScrollPhysics(),
                              children: List.generate(
                                  HomeCubit.get(context).projrctCM.length,
                                  (index) =>
                                      HomeCubit.get(context).projrctCM.length ==
                                                  0 &&
                                              HomeCubit.get(context)
                                                      .projrctAM
                                                      .length ==
                                                  0
                                          ? Center(
                                              child: Text(
                                                'انْتَظِرْ قَليلاً',
                                                style: TextStyle(fontSize: 50),
                                              ),
                                            )
                                          : projectItemBuilder(
                                              HomeCubit.get(context)
                                                  .projrctCM[index],
                                              HomeCubit.get(context)
                                                  .projrctAM[index],
                                              context)),
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.5,
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

  Widget projectItemBuilder(
      ProjectCategoryM modelC, ProjectAssociationM modelA, context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(
                    "https://d1qqr5712pvfjx.cloudfront.net/blobs/zm9r0utl6eehjitt3ham32lrye8d"),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${HomeCubit.get(context).title}',
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                          color: Colors.green[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${modelC.name}'),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${HomeCubit.get(context).description}',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17.0, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'جمع التبرعات',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SafeArea(
                    child: Container(
                      color: Colors.grey[50],
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  '300 من 1000 ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '% 30 ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 28,
                              animation: true,
                              lineHeight: 22.0,
                              isRTL: true,
                              animationDuration: 2500,
                              percent: 0.8,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: defaultColor,
                              backgroundColor: Colors.grey[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SafeArea(
                    child: Container(
                      color: Colors.grey[50],
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'المؤسسة ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${modelA.name}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      'المدينة ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${modelA.address}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              'البريد الالكتروني ${modelA.email}',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showToast(text: 'مشاركة', state: ToastStates.WARNING);
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.green,
                          width: 250,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'تبرع',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
            Text(
                      'معاً نحيا ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20.0,
                          
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
          ],
        ),
      ),
    );
  }
}
