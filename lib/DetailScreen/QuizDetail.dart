import 'dart:async';
import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:playandwin/util/SharedPreferences.dart';
import '../Data/Question.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../util/colors.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({Key? key}) : super(key: key);

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {

  late Future<Question> _futureQuestion;

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _futureQuestion = fetchQuestion();
  }*/

  @override
  Widget build(BuildContext context) {
    _futureQuestion = fetchQuestion(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
        title: Text('Quiz Screen'),
      ),
      body: FutureBuilder<Question>(
        future: _futureQuestion,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyWidget(question: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final Question question;

  const MyWidget({Key? key, required this.question}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late String _selectedOption,_questionNumber;
  late String userId;
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = '';
    _questionNumber = "1";
    userId = getUserIdPreferences("USER_ID") as String;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFFD1D1D1),
              width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Question :',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        widget.question.ques,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.0),
            CircularCountDownTimer(
              duration: 10,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 4,
              ringColor: Colors.white,
              fillColor: Colors.red,
              strokeWidth: 10.0,
              textStyle: TextStyle(fontSize: 22.0, color: Colors.black),
              isReverse: true,
              isReverseAnimation: true,
              onComplete: () {
                // Timer finished
              },
            ),
            Column(
              children: [
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap:()
                  {
                    setState(() {
                      _selectedOption = widget.question.opt1;
                    });
                    submitQuizAnswer(context,widget.question.id, widget.question.quizId, _selectedOption);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.question.opt1,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      _selectedOption = widget.question.opt2;
                    });
                    submitQuizAnswer(context,widget.question.id, widget.question.quizId, _selectedOption);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.question.opt2,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      _selectedOption = widget.question.opt3;
                    });
                    submitQuizAnswer(context,widget.question.id, widget.question.quizId, _selectedOption);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.question.opt3,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: ()
                  {
                    setState(() {
                      _selectedOption = widget.question.opt4;
                    });
                    submitQuizAnswer(context,widget.question.id, widget.question.quizId, _selectedOption);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.question.opt4,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<Question> fetchQuestion(BuildContext context) async {
  String userId = await getUserIdPreferences("USER_ID") as String;
  final response = await http.get(Uri.parse(
      'https://playandwin.xosstech.com/backend/public/api/quiz/1/'+userId+'?time=10:49:00'));
  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body)['data'][0]);
  } else {
    String errorMessage = "";
    try {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      errorMessage = errorResponse['message'];
    } catch (e) {
      errorMessage = "Failed to load question";
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("QUIZ UPDATE"),
          content: Text(errorMessage),
          actions: [
            MaterialButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    throw Exception(errorMessage);
  }
}

Future<void> submitQuizAnswer(BuildContext context,int questionId,int quizId,String submitAns) async {
  String userId = await getUserIdPreferences("USER_ID") as String;
  final response = await http.post(
    Uri.parse("https://playandwin.xosstech.com/backend/public/api/submit_ans"),
    body: {
      'user_id': userId,
      'question_id': questionId.toString(),
      'quiz_id':quizId.toString(),
      'submit_ans': submitAns,
      'submit_time': "02:00",
    },
  );

  if (response.statusCode == 201) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => quizScreen(),
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

