import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';

void signOut(context)
{


   CacheHelper.removeData(key: 'token').then((value) {
            if(value)
            {
              navigateAndFinish(context, LoginScreen());
            }
          });
             CacheHelper.removeData(key: 'pr_name').then((value) {
            if(value)
            {
              navigateAndFinish(context, LoginScreen());
            }
          });
     
        CacheHelper.removeData(key: 'pr_email').then((value) {
         
          });
     
     
          
}


void printFullText(String text){

  final Pattern = RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match) =>
  print(match.group(0)));
}

String? token = '';

String? pr_name = '';
String? pr_email = '';