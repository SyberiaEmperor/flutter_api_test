import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    http.Response response = await http.put(
      URL + "/user",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(
        <String, String>{
          "name": name,
        },
      ),
    );
    if (response.statusCode == 401)
      throw new NotAuthorized();
    else {
      print(jsonDecode(response.body)); //TODO: Implement actions
    }
  }
}

class NetworkException implements Exception {}

class NotAuthorized implements Exception {}
