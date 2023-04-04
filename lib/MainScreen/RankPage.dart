import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RankScreen extends StatefulWidget {
  const RankScreen({Key? key}) : super(key: key);

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {

  List _scoreList = [];

  @override
  void initState() {
    super.initState();
    _fetchScoreBoard();
  }

  Future<void> _fetchScoreBoard() async {
    final response =
    await http.get(Uri.parse('https://eade-103-166-187-83.ap.ngrok.io/api/ranking'));

    if (response.statusCode == 200) {
      setState(() {
        _scoreList = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load scores');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Board'),
      ),
      body: ListView.builder(
        itemCount: _scoreList.length,
        itemBuilder: (BuildContext context, int index) {
          final score = _scoreList[index];
          return Container(
            width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(score['name']),
                    Text(score['time']),
                    Text(score['score']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

