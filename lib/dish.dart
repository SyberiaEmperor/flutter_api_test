import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/funcs.dart';

class Dish {
  Requests reqs = Requests();

  String id;
  final String name;
  final String subName;
  final String price;
  final String caption1;
  final String caption2;
  final String caption3;
  int position;
  String picUrl;
  final String category;

  Dish(
      {this.name,
      this.subName,
      this.caption1 = '',
      this.caption2 = '',
      this.caption3 = '',
      this.price,
      @required this.id,
      @required this.position,
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
        category = data['category'],
        position = data['zindex'],
        picUrl = Requests.URL + data['picUrl'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subname': subName,
      'caption1': caption1,
      'caption2': caption2,
      'caption3': caption3,
      'price': price,
      'category': category,
      'picurl': picUrl,
      'zindex': position,
    };
  }
}

List<Dish> testlist = [
  new Dish(id: "001", name: "Пельмени", position: 0),
  new Dish(id: "002", name: "Борщ", position: 1),
  new Dish(id: "003", name: "Луперкаль", position: 2),
  new Dish(id: "004", name: "ТГК", position: 3),
  new Dish(id: "005", name: "Киста", position: 4),
  new Dish(id: "006", name: "Кистаочка", position: 5),
  new Dish(id: "007", name: "Царь-тряпка", position: 6),
  new Dish(id: "008", name: "Кирилл", position: 7),
];
