import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/chat_view.dart';

import 'dish.dart';
import 'funcs.dart';

class AdminMenu extends StatefulWidget {
  final String token;

  AdminMenu({this.token});

  @override
  _MenuState createState() => _MenuState(token: token);
}

class _MenuState extends State<AdminMenu> {
  _MenuState({this.token});
  Requests reqs = Requests();
  List<Dish> dishes = List<Dish>();
  Uint8List img = null;

  TextEditingController dishid = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController picurl = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController cap1 = TextEditingController();
  TextEditingController cap2 = TextEditingController();
  TextEditingController cap3 = TextEditingController();
  TextEditingController subname = TextEditingController();

  final String token;

  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: dishid,
              ),
              TextFormField(
                controller: category,
              ),
              TextFormField(
                controller: name,
              ),
              TextFormField(
                controller: picurl,
              ),
              TextFormField(
                controller: price,
              ),
              TextFormField(
                controller: cap1,
              ),
              TextFormField(
                controller: cap2,
              ),
              TextFormField(
                controller: cap3,
              ),
              TextFormField(
                controller: subname,
              ),
              FlatButton(
                onPressed: () async {},
                child: Text('get history'),
              ),
              FlatButton(
                onPressed: () async {
                  Dish dish = Dish(
                    name: name.text,
                    subName: subname.text,
                    caption1: cap1.text,
                    caption2: cap2.text,
                    caption3: cap3.text,
                    price: price.text,
                    id: dishid.text,
                    category: category.text,
                  );
                  await reqs.updateDish(token, dish);
                },
                child: Text('update dish'),
              ),
              FlatButton(
                onPressed: () async {
                  Dish dish = Dish(
                    name: name.text,
                    subName: subname.text,
                    caption1: cap1.text,
                    caption2: cap2.text,
                    caption3: cap3.text,
                    price: price.text,
                    category: category.text,
                  );
                  await reqs.addDish(token, dish, img);
                },
                child: Text('add'),
              ),
              FlatButton(
                onPressed: () async {
                  await reqs.deleteDish(token, dishid.text);
                },
                child: Text('delete dish'),
              ),
              FlatButton(
                onPressed: () async {
                  img = await reqs.getImageBytes();
                  this.setState(() {});
                },
                child: Text('load image'),
              ),
              CircleAvatar(
                radius: 125.5,
                backgroundImage: img == null
                    ? AssetImage('assets/images/logo.png')
                    : MemoryImage(img),
              ),
              FlatButton(
                onPressed: () {
                  reqs.ffs(img, token, dishid.text);
                },
                child: Text('upload image to server'),
              ),
              FlatButton(
                onPressed: () async {
                  testlist = await reqs.getDishes(token);
                },
                child: Text('get dishes'),
              ),
              FlatButton(
                onPressed: () async {
                  for (var i = 0; i < testlist.length; i++)
                    await reqs.addDish(token, testlist[i], img);
                },
                child: Text('get dishes'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chat_View(
                              token: token,
                            )),
                  );
                },
                child: Text('Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
