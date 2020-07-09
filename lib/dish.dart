import 'package:cached_network_image/cached_network_image.dart';

class Dish {
  String id;
  final String name;
  final String subName;
  final String price;
  final String caption1;
  final String caption2;
  final String caption3;

  final String category;

  Dish(
      {this.name,
      this.subName,
      this.caption1 = '',
      this.caption2 = '',
      this.caption3 = '',
      this.price,
      this.id = '',
      this.category});
  void printAll() {
    print("id = $id");
    print("name = $name");
    print("subName = $subName");
    print("caption1 = $caption1");
    print("caption2 = $caption2");
    print("caption3 = $caption3");
  }

  Dish.fromData(Map<String, dynamic> data)
      : name = data['name'],
        subName = data['subName'],
        caption1 = data['caption1'],
        caption2 = data['caption2'],
        caption3 = data['caption3'],
        price = data['price'],
        category = data['category'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subname': subName,
      'caption1': caption1,
      'caption2': caption2,
      'caption3': caption3,
      'price': price,
      'category': category,
    };
  }
}
