import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud/models/user.dart';

Future<User> fetchProfile(String token) async {
  final response = await http.get(
    Uri.parse('http://192.168.20.14/vapor/public/api/v1/login'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load profile');
  }
}
