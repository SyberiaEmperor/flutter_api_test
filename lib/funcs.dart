import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_web/image_picker_web.dart';

import 'dish.dart';

class Requests {
  static const URL = 'http://109.172.68.223:3000';

  ///Регистрация пользователя по номеру телефона и паролю
  Future<bool> reg(
      {@required String phoneNumber, @required String password}) async {
    if (password.trim().length < 4 || phoneNumber.trim().length < 4)
      return false;
    String body = jsonEncode(<String, dynamic>{
      "user": {"phone_number": phoneNumber, "password": password}
    });
    http.Response response = await http.post(URL + '/user',
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    return response.statusCode == 200; //200 = OK//250 - not OK
  }

  ///Получает jwt-токен для дальнейших запросов
  Future<String> getToken(
      {@required String login, @required String password}) async {
    String body = jsonEncode(<String, dynamic>{
      "auth": {"phone_number": login, "password": password}
    });
    http.Response response = await http.post(URL + '/user_token',
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 401) throw new NotAuthorized();
    if (response.statusCode == 201)
      return jsonDecode(response.body)["jwt"];
    else
      return null;
  }

  ///Получить информацию о пользователе
  Future<void> getProfile({@required String token}) async {
    http.Response response = await http
        .get(URL + "/user", headers: {HttpHeaders.authorizationHeader: token});
    if (response.statusCode == 401)
      throw new NotAuthorized();
    else {
      print(jsonDecode(response.body)); //TODO: Implement actions
    }
  }

  ///Изменить имя
  Future<void> changeName(
      {@required String token, @required String name}) async {
    var jsonen = jsonEncode(
      <String, dynamic>{
        "user": {"name": name}
      },
    );
    print(jsonen);
    http.Response response = await http.put(
      URL + "/user",
      headers: {
        HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/json'
      },
      body: jsonen,
    );
    if (response.statusCode == 401) throw new NotAuthorized();
  }

  ///Получает jwt-токен супер-пользователя для дальнейших запросов
  Future<String> getTokenAdmin(
      {@required String login, @required String password}) async {
    String body = jsonEncode(<String, dynamic>{
      "auth": {"login": login, "password": password}
    });
    http.Response response = await http
        .post(URL + '/superuser_token', body: body, headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 401) throw new NotAuthorized();
    if (response.statusCode == 201)
      return jsonDecode(response.body)["jwt"];
    else
      return null;
  }

  ///Получить информацию о супер-пользователе
  Future<void> getProfileAdmin({@required String token}) async {
    http.Response response = await http.get(URL + "/superuser",
        headers: {HttpHeaders.authorizationHeader: token});
    if (response.statusCode == 401)
      throw new NotAuthorized();
    else {
      print(jsonDecode(response.body)); //TODO: Implement actions
    }
  }

  Future<void> updateBasket(Map<String, int> basket, String token) async {
    var body = jsonEncode({"basket": basket});
    print(body);
    http.Response response = await http.post(URL + "/user/update_basket",
        headers: {
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json',
        },
        body: body);
    print(response);
  }

  ///Запрос на получение всех блюд
  Future<void> getDishes(String token) async {
    //TODO: Изменить возвращаемый тип данных
    http.Response response = await http.get(
      URL + "/dishes",
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(jsonDecode(response.body));
  }

  ///Запрос на добавление блюда
  Future<void> addDish(String token, Dish dish) async {
    //TODO: Поменять тип диша
    //TODO: Изменить возвращаемый тип данных
    print(jsonEncode({"dish": dish}));
    http.Response response = await http.post(
      URL + "/dishes",
      headers: {
        HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"dish": dish}),
    );
    print(response);
  }

  ///Запрос на получение блюда по его айди
  Future<void> getDish(String token, String id) async {
    //TODO: Изменить возвращаемый тип данных
    http.Response response = await http.get(
      URL + "/dishes/$id",
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response);
    print(jsonDecode(response.body));
  }

  ///Запрос на получение блюда по его айди
  Future<void> updateDish(String token, Dish dish, String id) async {
    //TODO: Переместить айдишник из параметров в тело функции
    //TODO: Изменить возвращаемый тип данных
    http.Response response = await http.put(
      URL + "/dishes/$id",
      headers: {
        HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"dish": dish}),
    );
    print(response);
  }

  ///Запрос на удаление блюда по его айди
  Future<void> deleteDish(String token, String id) async {
    //TODO: Изменить возвращаемый тип данных
    http.Response response = await http.delete(
      URL + "/dishes/$id",
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    print(response);
  }

  Future<Uint8List> getImageBytes() async {
    Uint8List bytesFromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (bytesFromPicker != null) {
      print(bytesFromPicker);
      return bytesFromPicker;
    } else
      return null;
  }

  Future<Image> getImageWidget() async {
    Image fromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.widget);

    if (fromPicker != null) {
      return fromPicker;
    } else
      return null;
  }
}

class NetworkException implements Exception {}

class NotAuthorized implements Exception {}
