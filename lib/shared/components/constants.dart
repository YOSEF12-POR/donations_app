import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/network/local/cache_helper.dart';

void signOut(context)
{

CacheHelper.removeData(key: 'iduser').then((value) {
          
          });

          CacheHelper.removeData(key: 'namepro').then((value) {
          
          });
          CacheHelper.removeData(key: 'emailpro').then((value) {
          
          });

   CacheHelper.removeData(key: 'token').then((value) {
            if(value)
            {
              navigateAndFinish(context, LoginScreen());
            }
          });
             
         
        
     
     
          
}


void printFullText(String text){

  final Pattern = RegExp('.{1,800}');
  Pattern.allMatches(text).forEach((match) =>
  print(match.group(0)));
}

String? token = '';
var iduser ;

String? tokenfcm ;


String? tor = '';
String? namepro = '';
String? emailpro = '';

int? number ;

String? numbervisa = ''; 