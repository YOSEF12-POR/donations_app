import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/home.dart';
import 'package:donations_app/layout/mainpage.dart';
import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:donations_app/modules/splash_screen/splash_screen.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:donations_app/shared/network/remote/dio_helper.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


// git add .
// git push origin master

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

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getHomeData()
              ..getGategoryData()..getFavorites()..getUserData()
             )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // English, no country code
      ],
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[100],
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
        home: SplashScreenView(
                navigateRoute: startWidget,
                duration: 5000,
                imageSize: 190,
                imageSrc: "assets/images/logo.png",
                text: "مكارم الخير",
                textType: TextType.ColorizeAnimationText,
                textStyle: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Jannah',
                  fontWeight: FontWeight.bold
                ),
                colors: const [
                  Colors.yellowAccent,
                  defaultColor, 
                 Colors.yellowAccent,
                 defaultColor, 
                  
                ],
      ),
    )
    );
  }
}
