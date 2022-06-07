
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
  final id;

  ProjectsDetails(this.id);

  @override
  State<ProjectsDetails> createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {
  bool islast = false;
  var Pagecontrolar = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
         listener: (context, state) {
    
      },
      builder: (context, state) {
    return Scaffold(
      
      body: state is ProjectLoadingState
          ? Center(
              child: CircularProgressIndicator(),
            )
          : HomeCubit.get(context).projrctCM.length == 0 && HomeCubit.get(context)
                                          .projrctAM
                                          .length ==
                                      0
              ? Center(
                  child: Text(
                    'انْتَظِرْ قَليلاً',
                    style: TextStyle(fontSize: 50),
                  ),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                       
                        // separator(0, 1),
                        GridView.count(
                          crossAxisCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                              HomeCubit.get(context).projrctCM.length,
                              (index) => HomeCubit.get(context)
                                          .projrctCM
                                          .length ==
                                      0 && HomeCubit.get(context)
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
                          crossAxisSpacing: 0,
                          childAspectRatio: 0,
                          mainAxisSpacing: 0,
                        ),
                      ],
                    ),
                  ),
                ),
    );
      },
    );
  }

  Widget projectItemBuilder(ProjectCategoryM modelC,ProjectAssociationM modelA, context) {
    return InkWell(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2)),
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
                            percent: 0.1,
                            center: Text(
                              '11 % ',
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
                                  '${modelC.name}',
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
                                        '11',
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
                                        '11',
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
                                  )),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
