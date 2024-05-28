import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final response = await http.get(
      Uri.parse('http://192.168.20.14/vapor/public/api/v1/login'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        user = jsonDecode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Correo'),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${user!['name']}',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text('Email: ${user!['email']}',
                      style: TextStyle(fontSize: 20)),
                  // Añade más campos según los datos disponibles
                ],
              ),
            ),
    );
  }
}
