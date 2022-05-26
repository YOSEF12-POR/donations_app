import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/modules/search/search_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
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
          // drawer: AppDrawer(),//---------------------
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'الأقسام'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_giftcard_rounded), label: 'المفضلة'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'حسابي'),
            ],
          ),
        );
      },
    );
  }
}
