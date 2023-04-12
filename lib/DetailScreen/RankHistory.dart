import 'package:flutter/material.dart';

import '../util/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankHistory extends StatefulWidget {
  const RankHistory({Key? key}) : super(key: key);

  @override
  State<RankHistory> createState() => _RankHistoryState();
}

class _RankHistoryState extends State<RankHistory> {

  List _quizAnswer = [];

  @override
  void initState() {
    super.initState();
    _fetchRankHistory();
  }

  Future<void> _fetchRankHistory() async {
    final response =
    await http.get(Uri.parse('https://playandwin.xosstech.com/backend/public/api/history/1'));

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
        title: Text('Rank History'),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Date: ', style: TextStyle(color: textColor),),
                          Text(quizAnswer['date'], style: TextStyle(color: textColor),)
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text('Answer: ', style: TextStyle(color: textColor),),
                          Text(quizAnswer['rank'], style: TextStyle(color: textColor),)
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
