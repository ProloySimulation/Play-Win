import 'package:flutter/material.dart';

class Question
{
  int id;
  int quizId;
  String ques;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  String ans;

  Question({
    required this.id,
    required this.quizId,
    required this.ques,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.ans,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      quizId: json['quiz_id'],
      ques: json['ques'],
      opt1: json['opt1'],
      opt2: json['opt2'],
      opt3: json['opt3'],
      opt4: json['opt4'],
      ans: json['c_ans'],
    );
  }
}