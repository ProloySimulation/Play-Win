import 'package:flutter/material.dart';
import 'package:playandwin/home.dart';

import '../util/colors.dart';
import 'package:http/http.dart' as http;

class BalanceWithdraw extends StatefulWidget {
  const BalanceWithdraw({Key? key}) : super(key: key);

  @override
  State<BalanceWithdraw> createState() => _BalanceWithdrawState();
}

class _BalanceWithdrawState extends State<BalanceWithdraw> {

  late String selectedRadio = "bkash";
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _walletController = TextEditingController();

  Future<void> postWithdraw() async {
    final response = await http.post(
      Uri.parse("https://playandwin.xosstech.com/backend/public/api/withdraw"),
      body: {
        'user_id': "1",
        'type': selectedRadio,
        'wallet_number':"01521110902",
        'amount': _textController.text,
      },
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
      // Handle successful response
      // Toast.show("Success", duration: Toast.lengthShort, gravity:  Toast.bottom);
    } else {
      throw Exception('Failed');
      // Handle error response
      // Toast.show("Error", duration: Toast.lengthShort, gravity:  Toast.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width < 600
              ? double.infinity
              : 400,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                height: 300,
                child: Card(
                  color: cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Amount',style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                            controller: _textController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Wallet Number',style: TextStyle(
                            color: Colors.white
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _walletController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: ()
                            {
                              postWithdraw();
                            },
                            child: Image.asset(
                              'assets/images/ic_array.png',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'bkash',
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value!;
                                    });
                                  },
                                ),
                                Text('Bkash', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'nagad',
                                  groupValue: selectedRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadio = value!;
                                    });
                                  },
                                ),
                                Text('Nagad', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
