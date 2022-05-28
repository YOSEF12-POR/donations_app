import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/category/categoriesDetailsModel.dart';
import 'package:donations_app/modules/cases/cases_screen.dart';
import 'package:donations_app/modules/home_screen.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;
  CategoryProductsScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {

    
     return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(
            title: Text('مكارم الخير',),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/images/logo.png')
                  ),
              ),
            ],
          ),
            body: state is CategoryDetailsLoadingState ?
            Center(child: CircularProgressIndicator(),) :  HomeCubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
            Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Text('$categoryName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ),
                      separator(0, 1),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          HomeCubit.get(context).categoriesDetailModel!.data.productData.length,
                              (index) => HomeCubit.get(context).categoriesDetailModel!.data.productData.length == 0 ?
                                 Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
                                 productItemBuilder(HomeCubit.get(context).categoriesDetailModel!.data.productData[index],context)
                              ),
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }

  Widget productItemBuilder (ProductData model,context) {
    return InkWell(
      onTap: (){
        HomeCubit.get(context).getCasesData(model.id.toString());
        navigateTo(context, CasesDetails(model.id));
        },
      child: Container(
        color: Colors.white,
        padding: EdgeInsetsDirectional.only(start: 8,bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Stack(
                alignment:AlignmentDirectional.bottomStart,
                children:[
                  Image(image: NetworkImage('${model.image}'),height: 150,width: 150,),
                  if(model.discount != 0 )
                    Container(
                        color: defaultColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('Discount',style: TextStyle(fontSize: 14,color: Colors.white),),
                        )
                    )
                ]),
            separator(0,10),
            Text('${model.name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
            Spacer(),
            Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                          Text('${model.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),),
                        ],
                      ),
                      separator(0, 5),
                      if(model.discount != 0 )
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                            Text('${model.oldPrice}',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            separator(7, 0),
                            Text('${model.discount}'+'% OFF',style: TextStyle(color: Colors.red,fontSize: 11),)
                          ],
                        ),
                    ]
                ),
                Spacer(),
                
              ],
            )
          ],
        ),
      ),
    );
  }

}