import 'dart:convert';
import 'package:card_app/controllers/credential.dart';
import 'package:card_app/models/card.dart';
import 'package:card_app/models/user.dart';
import 'package:dio/dio.dart';

class CardService {
  var dio =
      Dio(BaseOptions(baseUrl: 'https://api-cards-growdev.herokuapp.com'));

  Future<bool> login(User user) async {
    try {
      var response = await dio.post(
        "/login",
        data: jsonEncode(
          user.loginToJson(),
        ),
      );
      user.name = response.data['user']['name'];
      user.email = response.data['user']['email'];
      user.token = response.data['token'];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(User user) async {
    try {
      var response = await dio.post(
        "/users",
        data: jsonEncode(
          user.signUpToJson(),
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<List<CardGrowdev>> getAllCards() async {
    try {
      var response = await dio.get(
        '/cards',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userCredential.token}',
          },
        ),
      );
      return (response.data as List<dynamic>)
          .map((card) => CardGrowdev.fromMap(card))
          .toList();
    } catch (e) {
      return <CardGrowdev>[];
    }
  }

  Future<bool> updateCard(CardGrowdev card) async {
    try {
      await dio.put(
        '/cards/${card.id}',
        data: jsonEncode(
          card.toJson(),
        ),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userCredential.token}',
          },
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> createCard(CardGrowdev card) async {
    try {
      var response = await dio.post(
        '/cards',
        data: jsonEncode(
          card.toJson(),
        ),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userCredential.token}',
          },
        ),
      );
      return response.data['id'];
    } catch (e) {
      return 0;
    }
  }

  Future<bool> deleteCard(CardGrowdev card) async {
    try {
      var response = await dio.delete(
        '/cards/${card.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${userCredential.token}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
