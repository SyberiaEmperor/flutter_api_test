import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_view.dart';
import 'funcs.dart';

class Menu extends StatefulWidget {
  final String token;

  Menu({this.token});

  @override
  _MenuState createState() => _MenuState(token: token);
}

class _MenuState extends State<Menu> {
  _MenuState({this.token});
  Requests reqs = Requests();

  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  final String token;

  @override
  Widget build(BuildContext context) {
    print(token);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: phone,
            ),
            TextFormField(
              controller: password,
            ),
            TextFormField(
              controller: name,
            ),
            FlatButton(
              onPressed: () async {
                await reqs.reg(
                    phoneNumber: phone.text, password: password.text);
              },
              child: Text('registration'),
            ),
            FlatButton(
              onPressed: () async {
                await reqs.changeName(token: token, name: name.text);
              },
              child: Text('change name'),
            ),
            FlatButton(
              onPressed: () async {
                Map<String, int> basket = {"1": 10, "2": 3};
                await reqs.updateBasket(basket, token);
              },
              child: Text('update basket'),
            ),
            FlatButton(
              onPressed: () async {
                await reqs.getDishes(token);
              },
              child: Text('get dishes'),
            ),
            FlatButton(
              onPressed: () async {
                await reqs.getDish(token, 1.toString());
              },
              child: Text('get dish by id'),
            ),
            FlatButton(
              onPressed: () async {
                String id = await reqs.getProfile(token: token);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chat_View(
                            token: token,
                            id: id,
                          )),
                );
              },
              child: Text('Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
