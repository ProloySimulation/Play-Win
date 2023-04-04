import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:playandwin/Data/Profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? base64Image;

  Future pickImage() async {
    final html.FileUploadInputElement input =
    html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    await input.onChange.first;

    final reader = html.FileReader();
    reader.readAsDataUrl(input.files![0]);
    await reader.onLoad.first;

    base64Image = reader.result as String?;
    setState(() {});
  }

  Uint8List? _decodeBase64(String? base64String) {
    if (base64String == null) return null;
    return base64.decode(base64String.split(',').last);
  }

  Future<Profile> fetchData() async {
    final response =
    await http.get(Uri.parse('https://b571-103-166-187-82.ngrok.io/api/user/1'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Profile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<Profile>(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                else
                  {
                    final data = snapshot.data?.data;
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width < 600 ? double.infinity : 400,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                await pickImage();
                              },
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: _decodeBase64(base64Image) != null
                                    ? MemoryImage(_decodeBase64(base64Image)!) as ImageProvider
                                    : NetworkImage(data?.image ?? ''),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "John Doe",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(height: 20),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Name: "),
                                        Text(data?.name ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Email: "),
                                        Text(data?.email ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Phone Number: "),
                                        Text(data?.number ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Privacy: "),
                                        Text("Test Test"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}