import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List _notificationList = [];


  @override
  void initState() {
    super.initState();
    _fetchNotification();
  }

  Future<void> _fetchNotification() async {
    final response =
    await http.get(Uri.parse('https://playandwin.xosstech.com/backend/public/api/notification/1'));

    if (response.statusCode == 200) {
      setState(() {
        _notificationList = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load scores');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  color: cardColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Notification',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    itemCount: _notificationList.length,
                    itemBuilder: (BuildContext context,int index)
                    {
                      final notificationList = _notificationList[index];
                      return Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.brightness_1,
                              color: Colors.white,
                              size: 12.0,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                notificationList['description'],
                                style: TextStyle(fontSize: 16.0,color: textColor),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

