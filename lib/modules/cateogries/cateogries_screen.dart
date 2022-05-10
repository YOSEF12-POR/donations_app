import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/categories_model.dart';
import 'package:donations_app/shared/components/componets.dart';
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
                HomeCubit.get(context).categoryModel!.data.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: HomeCubit.get(context).categoryModel!.data.data.length,
              );
        }
        );
  }

  Widget buildCatItem(DataModelCa modelCa) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  modelCa.image),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
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
      );
}
