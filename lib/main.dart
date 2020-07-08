import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api_test/funcs.dart';
import 'package:flutter_api_test/reorderable_list_test.dart';
import 'package:http/http.dart' as http;

import 'admin_menu.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isAuth = false;
  String URL = "http://109.172.68.223:3000/";
  String token = null;

  Requests reqs = Requests();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: name,
            ),
            TextFormField(
              controller: password,
            ),
            FlatButton(
              onPressed: () async {
                token = await reqs.getTokenAdmin(
                    login: name.text, password: password.text);
                print(token +
                    "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////");
                if (token != null) {
                  await reqs.getProfileAdmin(token: token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminMenu(
                              token: token,
                            )),
                  );
                }
              },
              child: Text('Enter admin'),
            ),
            FlatButton(
              onPressed: () async {
                token = await reqs.getToken(
                    login: name.text, password: password.text);
                print(token +
                    "////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////");
                if (token != null) {
                  await reqs.getProfile(token: token);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Menu(
                              token: token,
                            )),
                  );
                }
              },
              child: Text('Enter'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reorder_Test()),
                );
              },
              child: Text('Test_1'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
