import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/category/categories_model.dart';
import 'package:donations_app/models/home_model/projects_model.dart';
import 'package:donations_app/modules/cateogries/category_projects_screen.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                HomeCubit.get(context).categoryModel!.data.data[index],
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: HomeCubit.get(context).categoryModel!.data.data.length,
          );
        });
  }

  Widget buildCatItem(DataModelCa modelCa, context) => InkWell(
        onTap: () {
          HomeCubit.get(context).getCategoriesDetailData(modelCa.id);
          navigateTo(context, CategoryProjectsScreen(modelCa.name));
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    image: NetworkImage(
                        "https://d1qqr5712pvfjx.cloudfront.net/blobs/zm9r0utl6eehjitt3ham32lrye8d"),
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  modelCa.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      );
}
