import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Image img = null;

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
                await reqs.updateDish(token, dish, dish.id);
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
                await reqs.addDish(token, dish);
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
                img = await reqs.getImageWidget();
                this.setState(() {});
              },
              child: Text('load image'),
            ),
            CircleAvatar(
              radius: 125.5,
              backgroundImage:
                  img == null ? AssetImage('assets/images/logo.png') : img,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  img = img;
                });
              },
              child: Text('update page'),
            ),
          ],
        ),
      ),
    );
  }
}
