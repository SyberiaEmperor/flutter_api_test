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
      : id = (data['id']).toString(),
        name = data['name'] ?? ' ',
        subName = data['subname'] ?? ' ',
        caption1 = data['caption1'] ?? ' ',
        caption2 = data['caption2'] ?? ' ',
        caption3 = data['caption3'] ?? ' ',
        price = data['price'] ?? ' ',
        category = data['category'] ?? ' ',
        position = data['zindex'];
  //picUrl = data['picUrl']['url'] ??
  //  ' '; // TODO: НЕ ПОТЕРЯТЬ Request.URL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subname': subName,
      'caption1': caption1,
      'caption2': caption2,
      'caption3': caption3,
      'price': price,
      'category': category,
      'picurl': {'url': picUrl},
      'zindex': position,
    };
  }
}

List<Dish> testlist = [
  new Dish(name: "Пельмени", price: "150"),
  new Dish(name: "Борщ", price: "150"),
  new Dish(name: "Луперкаль", price: "150"),
  new Dish(name: "ТГК", price: "150"),
  new Dish(name: "Киста", price: "150"),
  new Dish(name: "Кистаочка", price: "150"),
  new Dish(name: "Царь-тряпка", price: "150"),
  new Dish(name: "Кирилл", price: "150"),
];
