import 'message.dart';

class Chat {
  final String id;
  final String name;
  final String phoneNumber;
  final Message lastMsg;

  Chat({this.id, this.name, this.phoneNumber, this.lastMsg});
  Chat.fromJson(data)
      : id = data['id'].toString(),
        name = data['user']['name'] ?? "user#${data['id']}",
        phoneNumber = data['user']['phone_number'],
        lastMsg = data['last_message'] ?? new Message();

  void printChat() {
    print("chat_id is $id");
    print("name is $name");
    print("phoneNumber is $phoneNumber");
  }
}
