import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/categories_model.dart';
import 'package:donations_app/models/home_model.dart';
import 'package:donations_app/modules/cases_de/cases_de.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CasesScreen extends StatelessWidget {
  var amountController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeChangeSuccessFavoritesState) {
          if (!state.model.status!) {
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoryModel != null,
          builder: (context) => buliderWidget(HomeCubit.get(context).homeModel!,
              HomeCubit.get(context).categoryModel!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buliderWidget(
          HomeModel model, CategoryModel? categoryModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              // onTap: () {
              //   navigateTo(context, CasesDe());
              // },
              child: CarouselSlider(
                items: model.data.banners
                    .map(
                      (e) => Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: NetworkImage('${e.image}'),
                              width: 350,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Text('${e.name}'),
                        ],
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
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Categories',
                  //   style:
                  //       TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // Container(
                  //   height: 100,
                  //   child: ListView.separated(
                  //     physics: BouncingScrollPhysics(),
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) => buildCategoryItem(
                  //         categoryModel!.data.data[index], context),
                  //     separatorBuilder: (context, index) => SizedBox(
                  //       width: 10.0,
                  //     ),
                  //     itemCount: categoryModel!.data.data.length,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  Row(
                    children: [
                      Text(
                        'المشاريع',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, CasesDe());
                        },
                        child: Text(
                          'المزيد >>',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
                itemBuilder: (context, index) =>
                    buildCases(model.data.products[index], context),
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.0,
                ),
                itemCount: model.data.products.length,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
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
                height: 500,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'مكارم الخير في أرقام',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
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
                              Icon(Icons.monetization_on_outlined),
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
                                '1000,000,000 دولار',
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
                          color: Colors.blue[50],
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
                              Icon(Icons.monetization_on_outlined),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'عدد المستفيدين',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '500,500',
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
                          color: Colors.blue[50],
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
                              Icon(Icons.monetization_on_outlined),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'عدد عمليات التبرع',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '10,100,25',
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
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: Text(
                  '{ يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓاْ أَنفِقُواْ مِن طَيِّبَٰتِ مَا كَسَبْتُمْ }',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // Container(
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: GridView.count(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       crossAxisCount: 1,
            //       mainAxisSpacing: 3,
            //       crossAxisSpacing: 1,
            //       childAspectRatio: 1 / 1.9,
            //       children: List.generate(
            //         model.data.products.length,
            //         (index) =>
            //             buildGridCases(model.data.products[index], context),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
  Widget buildCategoryItem(DataModelCa model, context) => InkWell(
        // onTap: (){
        //     navigateTo(context, CasesDe());
        //     },
        child: Container(
          height: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.8),
                width: 100,
                child: Text(
                  model.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildCases(ProductModel model, context) => Container(
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
                    image: NetworkImage('${model.image}'),
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
                          percent: model.price / model.oldPrice,
                          center: Text(
                            '${(model.price / model.oldPrice * 100).round()} % ',
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
                                '${model.name}',
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
                                      '${model.oldPrice.round()} ',
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
                                      '${model.oldPrice.round() - model.price.round()}  دولار  ',
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
                                color: Colors.blue,
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
                              HomeCubit.get(context).changeFavorites(model.id);
                            },
                            icon: CircleAvatar(
                              radius: 30.0,
                              backgroundColor:
                                  HomeCubit.get(context).favorites[model.id]!
                                      ? defaultColor
                                      : Colors.grey,
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
      );
}
