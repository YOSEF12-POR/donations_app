import 'package:awesome_card/awesome_card.dart';
import 'package:donations_app/layout/cubit/cubit.dart';
import 'package:donations_app/layout/cubit/state.dart';
import 'package:donations_app/layout/home.dart';
import 'package:donations_app/shared/components/componets.dart';
import 'package:donations_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class MoneybackScreen extends StatefulWidget {
  @override
  State<MoneybackScreen> createState() => _MoneybackScreenState();
}

class _MoneybackScreenState extends State<MoneybackScreen> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;
  TextEditingController cardNumberCtrl = TextEditingController();
  TextEditingController expiryFieldCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('معاً نحيا'),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  CreditCard(
                    cardNumber: cardNumber,
                    cardExpiry: '**/**',
                    cardHolderName: '**********',
                    cvv: '***',
                    bankName: 'Thawani Portal',
                    showBackSide: showBack,
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                    // mask: getCardTypeMask(cardType: CardType.americanExpress),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: TextFormField(
                          controller: cardNumberCtrl,
                          decoration: InputDecoration(hintText: 'Card Number'),
                          maxLength: 16,
                          onChanged: (value) {
                            final newCardNumber = value.trim();
                            var newStr = '';
                            final step = 4;

                            for (var i = 0;
                                i < newCardNumber.length;
                                i += step) {
                              newStr += newCardNumber.substring(
                                  i, math.min(i + step, newCardNumber.length));
                              if (i + step < newCardNumber.length)
                                newStr += ' ';
                            }

                            setState(() {
                              cardNumber = newStr;
                            });
                          },
                        ),
                      ),

                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: Colors.green,
                            width: 250,
                            height: 50,
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      child: Center(
                                        child: AlertDialog(
                                          title: Text(
                                            'تأكيد',
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.red,
                                            ),
                                          ),
                                          content: Column(
                                            children: [
                                              Text(
                                                  'هل أنت متأكد من حسابك'),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  'سيصلك المبلغ خلال يومين كحد اقصى '),
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                             
                                                Spacer(),
                                                TextButton(
                                                  child: Text(' تراجع '),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Spacer(),
                                                Spacer(),
                                                Spacer(),
                                                TextButton(
                                                  child: Text('موافق'),
                                                  onPressed: () {
                                                    navigateAndFinish(
                                                        context, HomeLayout());
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'تحويل',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(
                      //     horizontal: 20,
                      //   ),
                      //   child: TextFormField(
                      //     controller: expiryFieldCtrl,
                      //     decoration: InputDecoration(hintText: 'Card Expiry'),
                      //     maxLength: 5,
                      //     onChanged: (value) {
                      //       var newDateValue = value.trim();
                      //       final isPressingBackspace =
                      //           expiryDate.length > newDateValue.length;
                      //       final containsSlash = newDateValue.contains('/');

                      //       if (newDateValue.length >= 2 &&
                      //           !containsSlash &&
                      //           !isPressingBackspace) {
                      //         newDateValue = newDateValue.substring(0, 2) +
                      //             '/' +
                      //             newDateValue.substring(2);
                      //       }
                      //       setState(() {
                      //         expiryFieldCtrl.text = newDateValue;
                      //         expiryFieldCtrl.selection = TextSelection.fromPosition(
                      //             TextPosition(offset: newDateValue.length));
                      //         expiryDate = newDateValue;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(
                      //     horizontal: 20,
                      //   ),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(hintText: 'Card Holder Name'),
                      //     onChanged: (value) {
                      //       setState(() {
                      //         cardHolderName = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(hintText: 'CVV'),
                      //     maxLength: 3,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         cvv = value;
                      //       });
                      //     },
                      //     focusNode: _focusNode,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
