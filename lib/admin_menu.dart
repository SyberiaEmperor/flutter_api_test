import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                await reqs.updateDish(
                    token,
                    {
                      "name": name.text,
                      "price": price.text,
                      "category": category.text
                    },
                    dishid.text);
              },
              child: Text('update dish'),
            ),
            FlatButton(
              onPressed: () async {
                await reqs
                    .addDish(token, {"name": name.text, "price": price.text});
              },
              child: Text('add'),
            ),
            FlatButton(
              onPressed: () async {
                await reqs.deleteDish(token, dishid.text);
              },
              child: Text('delete dish'),
            ),
          ],
        ),
      ),
    );
  }
}
