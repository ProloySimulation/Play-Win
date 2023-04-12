import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:playandwin/home.dart';
import 'package:http/http.dart' as http;

import '../util/SharedPreferences.dart';
import '../util/colors.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId,phoneNumber;
  const OtpScreen({Key? key, required this.verificationId, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: backgroundColor,
            width: MediaQuery
                .of(context)
                .size
                .width < 600 ? double.infinity : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_otp.png',
                  width: 150.0,
                  height: 150.0,
                ),
                SizedBox(height: 50.0),
                Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                Text(
                  'Please enter the OTP sent to your mobile',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                        (index) => SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _focusNodes[(index + 1) % 6].requestFocus();
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        String code = _controllers.map((c) => c.text).join();
                        PhoneAuthCredential credential = PhoneAuthProvider
                            .credential(
                            verificationId: widget.verificationId, smsCode: code);
                        await _auth.signInWithCredential(credential);
                        try {
                          getUserid();
                        }
                        catch (e) {

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: backgroundColor, // sets the button color
                        onPrimary: Colors.white, // sets the text color
                        side: BorderSide(width: 1, color: rankCardColor), // sets the border color and width
                      ),
                      child: Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getUserid() async {
    String url = 'https://playandwin.xosstech.com/backend/public/api/login';
    Map<String, String> body = {
      'number': widget.phoneNumber,
    };

    http.post(Uri.parse(url), body: body).then((response) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      int id = jsonResponse['data']['id'];
      setUserIdPreferences("USER_ID", id.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }).catchError((error) {});
  }
}
