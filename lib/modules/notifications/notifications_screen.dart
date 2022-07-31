import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/notifications_model/notifications_model.dart';
import 'package:donations_app/modules/cateogries/cateogries_convert.dart';
import 'package:donations_app/modules/cateogries/cateogries_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:donations_app/statistics/moneyback_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('الاشعارات'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildProjectNot(
                      HomeCubit.get(context).notificaytionsList[index],
                      context,
                      index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  itemCount: HomeCubit.get(context).notificaytionsList.length,
                ),
              ),
            ),
          );
        });
  }
}

var x = 0;
Widget buildProjectNot(Notifications model, context, index) => InkWell(
      onTap: () {
        if (model.is_read == 0) {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                child: Center(
                  child: AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          'تنويه',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                    content: Column(
                      children: [
                        Text('ان المشروع الذي قمت بتبرع به  تم إلغاءه'),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            '1.هل تريد تحويل المبلغ الى مشروع اخر 2. هل تريد ارجاع المبلغ الى حسابك'),
                      ],
                    ),
                    actions: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // TextButton(
                          //   child: Text('تحويل تلقائي'),
                          //   onPressed: () {},
                          // ),
                          Spacer(),
                          TextButton(
                            child: Text(' 1.تحويل المبلغ'),
                            onPressed: () {
                              navigateTo(context, CateogriesConvert());
                            },
                          ),
                          Spacer(),
                          Spacer(),
                          Spacer(),
                          TextButton(
                            child: Text('2.ارجاع المبلغ '),
                            onPressed: () {
                              navigateTo(context, MoneybackScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                child: Center(
                  child: AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          'تم',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green[50]),
                    child: Center(
                      child: Text(
                          '${HomeCubit.get(context).notificaytionsList.length - index}'),
                    )),
              ],
            ),
            SizedBox(
              height: 5.0,
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  child: Text(
                    '${model.title}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  child: Text(
                    '${model.body}',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
