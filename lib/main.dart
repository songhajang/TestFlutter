// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '#/': (context) => JSONGet(), // 초기 라우트로 FirstScreen을 설정
        '/second': (context) =>
            SecondScreen(), // '/second'란 경로로 SecondScrrent을 설정정
      },
      home: Scaffold(
        body: Center(
          child: JSONGet(),
        ),
      ),
    );
  }
}

class JSONGet extends StatefulWidget {
  @override
  _JSONGetState createState() => _JSONGetState();
}

class _JSONGetState extends State<JSONGet> {
  List<dynamic> data = [];

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.parse('http://jsonplaceholder.typicode.com/posts'),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = jsonDecode(response.body);
    });

    print(data);

    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Test Data"),
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        // itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: new TextButton(
                  onPressed: () {
                    // 라우트의 이름으로 새로운 라우트 적재
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Text(data[index]["title"])),
            ),
          );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // 현재 라우트를 pop(제거)
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
