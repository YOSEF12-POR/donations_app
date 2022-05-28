import 'package:carousel_slider/carousel_slider.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/models/home_model/cases_model.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class CasesDetails extends StatefulWidget {
  final id;

  CasesDetails(this.id);

  @override
  State<CasesDetails> createState() => _CasesDetailsState();
}

class _CasesDetailsState extends State<CasesDetails> {
  bool islast = false;
  var Pagecontrolar = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context)
          ..getCasesData(widget.id.toString()),
        child: BlocConsumer<HomeCubit, HomeStates>(
            builder: (context, state) => Scaffold(
                  backgroundColor: Colors.white,
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
                  body: state is CasesLoadingState
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: LinearProgressIndicator(
                              color: Colors.deepOrange,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        )
                      : HomeCubit.get(context).casesDetailsModel == null ?
                      const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: LinearProgressIndicator(
                        color: Colors.deepOrange,
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                      :bodyBuild(
                          context,
                          HomeCubit.get(context).casesDetailsModel,
                        ),
                ),
            listener: (context, state) {}));
  }

  Widget bodyBuild(context, CasesDetailsModel? model,) {
    List<Widget> images = [];
    model!.data!.images!.forEach((element) {
      images.add(Image.network(element, fit: BoxFit.contain));
    });
    return HomeCubit.get(context).casesDetailsModel == null
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  model.data!.name!,
                  style: const TextStyle(fontSize: 25),
                ),
                CarouselSlider(
                    items: images,
                    options: CarouselOptions(
                        height: 300,
                        onPageChanged: (x, reason) {
                          // HomeCubit.get(context).changeVal(x);
                        })),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  // child: Center(
                  //   child: AnimatedSmoothIndicator(
                  //       effect: const ExpandingDotsEffect(
                  //         activeDotColor: Colors.deepOrange,
                  //         spacing: 5.0,


                  //       ),
                  //       activeIndex: HomeCubit.get(context).value,
                  //       count: images.length),
                  // ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "${model.data!.price!.toString()} EGP",
                //       style: const TextStyle(
                //           fontSize: 20, color: Colors.deepOrange),
                //     ),
                //     const Spacer(),
                //     CircleAvatar(
                //       backgroundColor: HomeCubit.get(context).InCart[model.data.id] == true ?
                //       Colors.deepOrange: Colors.grey,
                //       child: IconButton(
                //         icon: const Icon(Icons.add_shopping_cart ,color: Colors.white,),
                //         onPressed: () {
                //           HomeCubit.get(context).changeCart(model.data.id);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Divider(
                    height: 2,
                    color: Colors.deepOrange,
                    endIndent: 10,
                    indent: 10,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(model.data!.description!)
              ],
            ),
          );
  }
}