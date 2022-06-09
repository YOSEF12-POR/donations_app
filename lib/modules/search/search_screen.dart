import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/models/home_model/projects_model.dart';
import 'package:donations_app/models/search_model.dart';
import 'package:donations_app/modules/project/project_screen.dart';
import 'package:donations_app/modules/search/cubit/cubit.dart';
import 'package:donations_app/modules/search/cubit/state.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    defaultFormFiled(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmitt: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingStates) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListCases(
                            SearchCubit.get(context).projrctSM[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).projrctSM.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListCases(
    ProjectS model,
    
    context,
  ) =>
      InkWell(
        onTap: () {
          HomeCubit.get(context).getProjectData(model.id);
          print(model.title);
          navigateTo(context, ProjectsDetails());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1),
                  topRight: Radius.circular(1),
                  bottomLeft: Radius.circular(1),
                  bottomRight: Radius.circular(1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100]!,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            height: 400,
            width: double.infinity,
            child: Container(
              height: 100,
              width: 400,
              child: Column(
                children: [
                  Stack(
                    children: [           
                      Image(
                        image: NetworkImage(
                            "https://d1qqr5712pvfjx.cloudfront.net/blobs/zm9r0utl6eehjitt3ham32lrye8d"),
                        width: double.infinity,
                        height: 210,
                        fit: BoxFit.cover,
                      ),
                 
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Text(
                              '${model.title}',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 19.0,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '300 من 1000 ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      ' ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width - 60,
                                  animation: true,
                                  lineHeight: 22.0,
                                  isRTL: true,
                                  animationDuration: 2500,
                                  percent: 0.8,
                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  progressColor: defaultColor,
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
