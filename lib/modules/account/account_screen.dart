import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(body: Text('fer'),);
          // return ConditionalBuilder(
          //   condition: state is! HomeLoadingGetFavoritesState,
          //   builder:(context) => ListView.separated(
          //       physics: BouncingScrollPhysics(),
          //       itemBuilder: (context, index) => buildListfCases(HomeCubit.get(context).favoritesModel!.data!.data![index].product! ,context),
          //       separatorBuilder: (context, index) => myDivider(),
          //       itemCount: HomeCubit.get(context).favoritesModel!.data!.data!.length,
          //       ),
          //       fallback: (context) => Center(child: CircularProgressIndicator()),
          // );
        }
    );
        }
   }


  
