import 'dart:convert';
import 'package:api_integration/model/user_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserRespository {
  Future<List<UserResponse>> getUserList() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final http.Response response = await http.get(url);
    debugPrint('method called');
    List<UserResponse> userResponseList = [];
    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        userResponseList.add(UserResponse.fromJson(item));
      }
      return userResponseList;
    } else {
      throw Exception("Failed to load user");
    }
  }
}
