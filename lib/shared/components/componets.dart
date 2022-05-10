import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
  Color back = Colors.blue,
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