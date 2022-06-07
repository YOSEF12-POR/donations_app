import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormFiled({
  required TextEditingController controller,
  required TextInputType type,
  onSubmitt,
  onChange,
  onTap,
  IconData? suffix,
  required validate,
  VoidCallback? suffixpressed,
  bool? isClickable = true,
  bool isPassword = false,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmitt,
      onTap: onTap,
      validator: validate,
      enabled: isClickable!,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

defaultMaterialButton({
  required VoidCallback? onpressed,
  String? text,
  TextStyle? style,
  ShapeBorder? shape,
  Color? color,
  double? minwidth,
  double? height,
}) =>
    MaterialButton(
      onPressed: onpressed,
      child: Text(
        text!.toUpperCase(),
        style: style,
      ),
      shape: shape,
      color: color,
      minWidth: minwidth,
      height: height,
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => Widget), (route) {
      return false;
    });

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: Center(
          child: Text(
            text.toUpperCase(),
          ),
        ));

Widget defaultButton({
  double wid = double.infinity,
  double r = 3.0,
  required String text,
  bool isUpper = true,
  Color back = Colors.green,
  required Function function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);


enum ToastStates{SUCCESS , ERROR , WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListfCases(model,context , {bool isoldprice = true, } ) =>  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image(
                  image: NetworkImage(
                      model.image!),
                  width: 120.0,
                  fit: BoxFit.cover,
                  height: 120.0,
                ),
                if ( model.discount! != 0 && isoldprice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'الفرصة دائمة ',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     model.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                         '${model.price!.toString()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount! != 0 && isoldprice)
                        Text(
                          '${model.oldPrice!.toString()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     // HomeCubit.get(context).changeFavorites(model.id!);
                      //   },
                      //   icon: CircleAvatar(
                      //     radius: 30.0,
                      //     backgroundColor:
                      //         HomeCubit.get(context).favorites[model.id]!
                      //          ? defaultColor 
                      //          : Colors.grey,
                      //     child: Icon(
                      //       Icons.wallet_giftcard_rounded,
                      //       size: 22.0,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


    Widget separator (double wide,double high){
  return SizedBox(width: wide,height: high,);
}