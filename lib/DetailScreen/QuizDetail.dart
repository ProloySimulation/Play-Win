import 'dart:async';
import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Data/Question.dart';
import 'package:fluttertoast/fluttertoast.dart';

class quizScreen extends StatefulWidget {
  const quizScreen({Key? key}) : super(key: key);

  @override
  State<quizScreen> createState() => _quizScreenState();
}

class _quizScreenState extends State<quizScreen> {

  late Future<Question> _futureQuestion;
  late String _questionNumber;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _futureQuestion = fetchQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOption = '';
    _questionNumber = "1";
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


Future<Question> fetchQuestion() async {
  // Toast.show("Success", duration: Toast.lengthShort, gravity:  Toast.bottom);
  try {
    final response = await http.get(Uri.parse(
        'https://playandwin.xosstech.com/backend/public/api/quiz/1/' + "1" +
            '?time=10:49:00'));
    if (response.statusCode == 200) {
      return Question.fromJson(jsonDecode(response.body)['questions_date'][0]);
    } else {
      throw Exception('Failed to load question');
    }
  }
  catch (e) {
    print(e);
    Fluttertoast.showToast(
      msg: 'The Quiz Has Not Started Yet',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    throw Exception('Failed to load question');
  }
}

Future<void> submitQuizAnswer(BuildContext context,int questionId,int quizId,String submitAns) async {
  // Toast.show("Success", duration: Toast.lengthShort, gravity:  Toast.bottom);
  final response = await http.post(
    Uri.parse("https://ec69-103-166-187-82.ngrok.io/api/submit_ans"),
    body: {
      'user_id': "1",
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

