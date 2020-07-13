import 'package:flutter/material.dart';
import 'package:flutter_api_test/dish.dart';

import 'package:reorderables/reorderables.dart';

import 'funcs.dart';

class Chat_View extends StatefulWidget {
  final token;
  final id;
  Chat_View({Key key, this.token, this.id}) : super(key: key);

  @override
  _Chat_ViewState createState() => _Chat_ViewState(token, id);
}

class _Chat_ViewState extends State<Chat_View> {
  final token;
  final id;
  _Chat_ViewState(this.token, this.id);

  Requests reqs = Requests();
  Chat chat = Chat();
  int idx;
  List<Widget> messages = List<Widget>();

  @override
  void initState() {
    super.initState();
    chat.superUserChat(token, "message", "2");
    idx = 1;
    messages.add(Container(
      child: Text("Message" + idx.toString()),
    ));
  }

  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 50,
                child: TextFormField(
                  controller: text,
                ),
              ),
              FlatButton(
                onPressed: () {
                  idx++;
                  setState(() {
                    messages.add(Container(
                      child: Text('Message' + idx.toString()),
                    ));
                  });
                },
                child: Text('Add message'),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: messages,
            ),
          ),
        ],
      ),
    );
  }
}
