import 'package:flutter/material.dart';

class Message {
  final DateTime time; //TODO: Переработать в DateTime
  final String sender;
  final int type;
  final String content;

  Message(
      {@required this.time,
      @required this.sender,
      @required this.type,
      @required this.content});
  Message.fromJson(Map<String, dynamic> data)
      : time = DateTime.parse(data['created_at']),
        sender = data['sender_type'],
        type = data['type_message'],
        content = data['type_message'] == 2
            ? "http://109.172.68.223:3000" + data['picture']['url']
            : data['content'] ?? data['message'];
  void printMessage() {
    print('time is $time');
    print('sender is $sender');
    print('type is $type');
    print('content is $content');
  }
}
