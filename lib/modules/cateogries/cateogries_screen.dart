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
          return Scaffold(
              body: state is HomeLoadingHomeDataState
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
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildCatItem(
                              HomeCubit.get(context)
                                  .categoryModel!
                                  .data
                                  .data[index],
                              context),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: HomeCubit.get(context)
                              .categoryModel!
                              .data
                              .data
                              .length,
                        ));
        });
  }

  Widget buildCatItem(DataModelCa modelCa, context) => InkWell(
        onTap: () {
          HomeCubit.get(context).getCategoriesDetailData(modelCa.id);
          navigateTo(context, CategoryProjectsScreen(modelCa.name));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Image(
                  image: NetworkImage("${baseUrlImage}${modelCa.imagePath}"),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${modelCa.name}',
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      );
}
