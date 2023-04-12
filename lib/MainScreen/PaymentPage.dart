import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:playandwin/DetailScreen/BalanceWithdraw.dart';
import '../Data/Profile.dart';
import '../util/SharedPreferences.dart';
import '../util/colors.dart';

class PaymentScreen extends StatelessWidget {
  late String user_id;
  Future<Profile> fetchData() async {
    String userId = await getUserIdPreferences("USER_ID") as String;
    final response = await http.get(Uri.parse(
        'https://playandwin.xosstech.com/backend/public/api/user/' + userId));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Profile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Expanded(
            child: Container(
              color: backgroundColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width < 600
                  ? double.infinity
                  : 400,
              child: Column(
                children: [
                  FutureBuilder<Profile>(
                    future: fetchData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        final data = snapshot.data?.data;
                        user_id = (data?.id).toString();
                        return Card(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Balance - ',
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data?.balance ?? '',
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
                        );
                      }
                    },
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BalanceWithdraw(),
                        ),
                      );
                    },
                    child: Card(
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
                                    'Withdraw',
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
                  ),
                  GestureDetector(
                    onTap: () {
                      html.window.open(
                          "https://playandwin.xosstech.com/Payment/bkash/payment.php?user_id=" +
                              user_id +
                              "&id=PNW10win",
                          '_blank');
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
                                        color: textColor),
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
                    onTap: () {
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
      'amount': "20",
      'user_id': "1",
    };

    http.post(Uri.parse(url), body: body).then((response) {
      String jsonRes = response.body.toString();
      extractUrl(jsonRes);
    }).catchError((error) {});
  }

  void extractUrl(String string) {
    RegExp regExp = RegExp(r'"callBackUrl"\s*:\s*"([^"]+)"');
    Match match = regExp.firstMatch(string) as Match;
    if (match != null) {
      String? callBackUrl = match.group(1);
      print(callBackUrl);
      html.window.open(callBackUrl ?? "", '_blank');
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
