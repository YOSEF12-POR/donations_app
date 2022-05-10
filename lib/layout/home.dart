import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('تبرعات'),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              
              onTap: (index) {
                cubit.ChangeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
             
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
              
              ),
        );
      },
    );
  }
}
