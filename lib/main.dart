import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/home.dart';
import 'package:donations_app/layout/mainpage.dart';
import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // بيتاكد انه كل حاجه في هذه الميثود اشتغلت وخلصت بعدين بيشغل التطبيق

  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  print('-----');
  print(onBoarding);
  print(token);

  runApp(MyApp(starWidget: widget));
}

class MyApp extends StatelessWidget {
  Widget? starWidget;
  MyApp({this.starWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getHomeData()
              ..getGategoryData()..getFavorites()
             )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleSpacing: 20.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(
              color: defaultColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey,
            ),
            elevation: 20.0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: defaultColor,
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          fontFamily: 'Jannah',
          primarySwatch: defaultColor,
        ),
        home: starWidget,
      ),
    );
  }
}
