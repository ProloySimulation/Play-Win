import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import '../util/colors.dart';

class PaymentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Expanded(
            child: Container(
              color: backgroundColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    color: cardColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Balance - 100 BDT',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      html.window.open("https://playandwin.xosstech.com/Payment/bkash/payment.php?user_id=1&id=PNW10win", '_blank');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      color: paymentCardColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ic_bkash.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 40.0),
                                  Text(
                                    'Pay with bkash ',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                        color: textColor
                                    ),
                                  ),
                                  SizedBox(width: 40.0),
                                  Image.network(
                                    'https://picsum.photos/100',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      nagadCallBack();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      color: paymentCardColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ic_nagad.png',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 40.0),
                                  Text(
                                    'Pay with Nagad ',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  Image.network(
                                    'https://picsum.photos/100',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> nagadCallBack() async {
    String url = 'https://playandwin.xosstech.com/Payment/nagad/index.php';
    Map<String, String> body = {
      'amount': "10",
      'user_id': "1",
    };

    http.post(Uri.parse(url), body: body).then((response) {
      String jsonRes = response.body.toString();
      extractUrl(jsonRes);
    }).catchError((error) {
    });
  }

  void extractUrl(String string) {

    RegExp regExp = RegExp(r'"callBackUrl"\s*:\s*"([^"]+)"');
    Match match = regExp.firstMatch(string) as Match;
    if (match != null) {
      String? callBackUrl = match.group(1);
      print(callBackUrl);
      html.window.open(callBackUrl ?? "",'_blank');
    }
    /*for (String str in list) {
      nagadUrl = str;
      html.window.open(nagadUrl,'_blank');
      Fluttertoast.showToast(
          msg: string,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }*/
  }
}
