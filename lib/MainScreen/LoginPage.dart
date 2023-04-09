import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playandwin/MainScreen/OtpPage.dart';

class LoginScreen extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textController = TextEditingController();

  // const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_login.png',
                ),
                SizedBox(height: 16.0),
                Text(
                  'OTP Verification',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'We will send you a one time password',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String phoneNumber = "+88"+_textController.text;
                      verifyPhoneNumber(phoneNumber,context);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => OtpScreen(),
                        ),
                      );*/
                      // TODO: Implement login functionality
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber,BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of verification code completed.
        // Sign in the user with the credential.
        await _auth.signInWithCredential(credential);
        // Navigate to the verification screen.
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen()),
        );*/
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        // Handle other errors.
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID somewhere or use it to display a message to the user.
        // Navigate to the verification screen.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verificationId)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }
}
