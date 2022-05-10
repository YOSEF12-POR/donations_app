import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool ismale = true;
  double max = 20;
  double min = 0;
  double isbtn = 100;
  double weight = 0.9;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BIM CLCLATUER'),
      ),

      body: Column(
        children: [
          Container(
            child: LinearPercentIndicator(
              
            ),
          ),
       Padding(
              padding: EdgeInsets.all(15.0),
              child: new 
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: weight,
                center: Text('${weight*100} % '),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
        ],
      ),

                
              );
                
  }
}
