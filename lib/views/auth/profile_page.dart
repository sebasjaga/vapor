import 'package:flutter/material.dart';
import 'package:crud/models/user.dart';
import 'package:crud/services/profile_services.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({required this.token, super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: FutureBuilder<User>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Perfil'),
                      subtitle: Text('Bienvenido, ${snapshot.data!.name}'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Este es tu perfil: ${snapshot.data!.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Correo: ${snapshot.data!.email}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
