import 'package:flutter/material.dart';
import 'package:playandwin/DetailScreen/QuizDetail.dart';
import 'package:playandwin/MainScreen/RankPage.dart';

import '../DetailScreen/QuizAnswer.dart';
import '../DetailScreen/RankHistory.dart';
import '../util/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: backgroundColor,
            width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 40),
                Text(
                  'Hello, Striker',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                ),
                Text(
                  'What would you like to do ?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => quizScreen(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      color: cardColor,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width > 768 ? 100 : 150,
                                        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
                                        child: Center(
                                          child: Text(
                                            'Daily Quiz',
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => quizAnswer(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color: cardColor,
                                      elevation: 5,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width > 768 ? 100 : 150,
                                        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
                                        child: Center(
                                          child: Text(
                                            'Quiz Result',
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => RankScreen(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color: cardColor,
                                      elevation: 5,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width > 768 ? 100 : 150,
                                        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
                                        child: Center(
                                          child: Text(
                                            'Top 10 Candidate',
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => RankHistory(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color: cardColor,
                                      elevation: 5,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width > 768 ? 100 : 150,
                                        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
                                        child: Center(
                                          child: Text(
                                            'Rank History',
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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
}

class VerticalCardView extends StatelessWidget {
  const VerticalCardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: Center(
          child: Text(
            'This is a Card',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
