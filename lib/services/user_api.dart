import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_developer_test_task/models/user_model.dart';

class UserApi {
  final String baseUrl = "https://api.byteplex.info";

  Future<bool> sendUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.byteplex.info/api/test/contact/"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );
      return response.statusCode == 201 ? true : false;
    } on Exception {
      return false;
    }
  }
}
