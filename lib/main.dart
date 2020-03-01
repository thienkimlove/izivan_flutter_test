// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getLogin(),
        initialData: "Loading text..",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return new Text(
            text.data,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          );
        });
  }
}

Future<String> getLogin() async {
  // set up POST request arguments
  String url = 'https://izivan.com.vn/apiv2/merchant-login';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"password": "tieungao", "phone": "0903347191"}';
  // make POST request
  Response response = await post(url, headers: headers, body: json);
  // check the status code for the result
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String body = response.body;
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
  return body;
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}