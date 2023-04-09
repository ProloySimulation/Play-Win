import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../util/colors.dart';

class quizAnswer extends StatefulWidget {

  @override
  State<quizAnswer> createState() => _quizAnswerState();
}

class _quizAnswerState extends State<quizAnswer> {

  List _quizAnswer = [];

  @override
  void initState() {
    super.initState();
    _fetchScoreBoard();
  }

  Future<void> _fetchScoreBoard() async {
    final response =
    await http.get(Uri.parse('https://playandwin.xosstech.com/backend/public/api/result/1/1'));

    if (response.statusCode == 200) {
      setState(() {
        _quizAnswer = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load scores');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
        title: Text('Quiz Answer'),
      ),
      body: Center(
        child: Container(
          color: backgroundColor,
          width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
          child: ListView.builder(
            itemCount: _quizAnswer.length,
            itemBuilder: (BuildContext context, int index)
            {
              final quizAnswer = _quizAnswer[index];
              return Container(
                child: Card(
                  color: rankCardColor,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text('Question: ', style: TextStyle(color: textColor),),
                            Text(quizAnswer['ques'], style: TextStyle(color: textColor),)
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text('Answer: ', style: TextStyle(color: textColor),),
                            Text(quizAnswer['c_ans'], style: TextStyle(color: textColor),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

