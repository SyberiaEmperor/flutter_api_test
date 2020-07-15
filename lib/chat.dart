import 'package:flutter/material.dart';

import 'message.dart';

class Chat {
  final String id;
  final String name;
  final String phoneNumber;
  final Message lastMsg;

  Chat(
      {@required this.id,
      @required this.name,
      @required this.phoneNumber,
      @required this.lastMsg});
  Chat.fromJson(data)
      : id = data['id'].toString(),
        name = data['user']['name'] ?? "user#${data['id']}",
        phoneNumber = data['user']['phone_number'],
        lastMsg = data['last_message'] == null
            ? defaultMessage
            : new Message.fromJson(
                data['last_message']); //TODO: Мб сообщение-заглушку?

  void printChat() {
    print("chat_id is $id");
    print("name is $name");
    print("phoneNumber is $phoneNumber");
  }
}

Message defaultMessage = new Message(
    content: "No content", sender: "User", time: new DateTime(2020), type: 1);
