import 'package:carousel_slider/carousel_slider.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/category/categories_model.dart';
import 'package:donations_app/models/home_model/home_model.dart';
import 'package:donations_app/modules/cateogries/category_projects_screen.dart';
import 'package:donations_app/modules/cateogries/cateogries_screen.dart';
import 'package:donations_app/modules/payment/payment_screen.dart';
import 'package:donations_app/modules/project/project_screen.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:donations_app/statistics/moneyback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var amountController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> _handRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: state is HomeLoadingHomeDataState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : HomeCubit.get(context).bannersListH.length == 0
                  ? Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset('assets/images/no.png'),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              items: HomeCubit.get(context)
                                  .bannersListH
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        HomeCubit.get(context)
                                            .getCategoriesDetailData(e.id);
                                        navigateTo(context,
                                            CategoryProjectsScreen(e.name));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  "${baseUrlImage}${e.imagePath}"),
                                              width: 350,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              width: 350,
                                              height: 200,
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.bottomCenter,
                                              child: Text(
                                                '${e.name}',
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: Colors.white),
                                              ),
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 4),
                                autoPlayAnimationDuration: Duration(seconds: 1),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              '  اخر المشاريع   ',
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
                                itemBuilder: (context, index) => buildProjects(
                                    HomeCubit.get(context).projectsListH[index],
                                    context),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 10.0,
                                ),
                                itemCount:
                                    HomeCubit.get(context).projectsListH.length,
                              ),
                            ),
                            Container(
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
                              height: 500,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'معاً نحيا في أرقام',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Jannah',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
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
                                      height: 120.0,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                                Icons.monetization_on_outlined),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'عدد المشاريع المكتملة',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '${HomeCubit.get(context).sum_received_amount}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
                                      height: 120.0,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                                Icons.monetization_on_outlined),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'عدد المشاريع المفتوحة ',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '${HomeCubit.get(context).count_project}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
                                      height: 120.0,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                                Icons.monetization_on_outlined),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'إجمالي التبرعات',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '${HomeCubit.get(context).sum_num_beneficiaries}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  '{ يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓاْ أَنفِقُواْ مِن طَيِّبَٰتِ مَا كَسَبْتُمْ }',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }

  Widget buildProjects(ProjectsModel model,  context) => InkWell(
        onTap: () {
          HomeCubit.get(context).getProjectData(model.id);
          print(model.title);
          navigateTo(context, ProjectsDetails());
        },
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
                            percent:
                                model.received_amount / model.require_amount,
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
                                            fontSize: 14.0,
                                            color: defaultColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
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
                                            fontSize: 14.0,
                                            color: defaultColor),
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
                            Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Colors.green,
                                width: 250,
                                height: 40,
                                child: defaultButton(
                                    text: 'تبرع',
                                    function: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            SingleChildScrollView(
                                          child: Container(
                                            child: AlertDialog(
                                              title: Text('تبرع'),
                                              content: Column(
                                                children: [
                                                  Text(
                                                      'ادخل المبلغ المراد التبرع به '),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  defaultFormFiled(
                                                      controller:
                                                          amountController,
                                                      type:
                                                          TextInputType.number,
                                                      validate: (value) {
                                                        if (value.isEmpty) {
                                                          return 'ادخل المبلغ المراد التبرع به ';
                                                        }
                                                        return null;
                                                      },
                                                      label: 'المبلغ',
                                                      prefix: Icons.monetization_on_sharp),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  // Text(
                                                  //   'تنبيه',
                                                  //   style: TextStyle(
                                                  //     fontSize: 25,
                                                  //     color: Colors.red,
                                                  //   ),
                                                  // ),
                                                  // Text(
                                                  //     '  اذا لم يتم اكمال  المبلغ المطلوب للمشروع و لم يصل حد التبرع المشروع الى 50%  سيتم تحويل  اموال المشروع الى مشروع اخر'),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('تراجع'),
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    print(amountController);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('موافق'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PYMENTSCREEN(
                                                                    amountController
                                                                        .text,
                                                                    model.id,iduser
                                                                    ))
                                                                    
                                                                    );

                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Spacer(),
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
}
