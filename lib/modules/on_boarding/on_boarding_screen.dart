import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/modules/welcome/welcome_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel {
  late final String image;
  late final String title;
  late final String body;
  BordingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BordingModel> boarding = [
    BordingModel(
        image: 'assets/images/on1.png',
        title: 'المساعدة المناسبة في الوقت المناسب',
        body: ' يوفر التطبيق العديد من فرص التبرع'),
    BordingModel(
        image: 'assets/images/on2.png',
        title: 'مراقبة النظام',
        body: 'يحتوي التطبيق على نظام للمراقبة التبرعات ويتم متابعته من هيئة إشرافية'),
    BordingModel(
        image: 'assets/images/on3.png',
        title: 'التبرع بأمان',
        body: 'يمكنك التبرع والمساهمة بطرق أمنة'),
  ];

  bool isLast = false;
void submit(){
    CacheHelper.saveData(key:'onBoarding' , value:true ).then((value){
      if(value)
      {
        navigateAndFinish(context,WelcomeScreen());
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit
                
             ,
              text: 'تخطي'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 3,
                        spacing: 5.0),
                    count: boarding.length),
                Spacer(),
                // FloatingActionButton(
                //   onPressed: () {
                //     if (isLast) {
                //       submit;
                //     } else {
                //       boardController.nextPage(
                //           duration: Duration(milliseconds: 750),
                //           curve: Curves.fastLinearToSlowEaseIn);
                //     }
                //   },
                //   child: Icon(Icons.arrow_forward_ios),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
