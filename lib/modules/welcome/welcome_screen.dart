import 'package:donations_app/modules/login/login_screen.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
//'assets/images/background.jpg'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset('assets/images/background.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ClipOval(
                          child: Container(
                            width: 150,
                            height: 150,
                            color: Colors.green[50],
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/logo11.png'),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        child: Text('معاً نحيا ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 40),
                      Text('مرحبا بك في التطبيق ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 40),
                      Center(
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.green,
                          width: 250,
                          height: 50,
                          child: FlatButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: Text(
                              'مرحبا بك ',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ),
                      
                    ],
                  ),
                )
              ],
            )));
  }
}
