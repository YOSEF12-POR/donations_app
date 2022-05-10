import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/favorites_model.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! HomeLoadingGetFavoritesState,
            builder:(context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavItem(HomeCubit.get(context).favoritesModel!.data!.data![index] ,context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: HomeCubit.get(context).favoritesModel!.data!.data!.length,
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        }
    );
        }
   }


  Widget buildFavItem(FavoritesData model,context ) =>  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image(
                  image: NetworkImage(
                      model.product!.image!),
                  width: 120.0,
                  fit: BoxFit.cover,
                  height: 120.0,
                ),
                if ( model.product!.discount! != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'الفرصة دائمة ',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     model.product!.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                         '${model.product!.price!.toString()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount! != 0)
                        Text(
                          '${model.product!.oldPrice!.toString()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 30.0,
                          backgroundColor:
                              HomeCubit.get(context).favorites[model.product!.id]!
                               ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
