import 'package:flutter/material.dart';
import 'package:signup_login/models/user.dart';
import 'package:signup_login/services/auth.dart';
import 'package:signup_login/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFBFBFF),
          elevation: 0.0,
          leading: InkWell(
            onTap: () {},
            child: IconButton(
              icon: const Icon(Icons.person),
              color: Colors.black,
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () {},
            ),
          ),
          title: Text(
            'Accounts',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.logout_outlined),
              label: Text('logout'),
              style: TextButton.styleFrom(primary: Colors.black),
              onPressed: () async {
                print("logging out");
                await _auth.logout();
              },
            ),
          ]),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: snapshot.data!.docs.map((doc) {
                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: theme.primaryColor,
                    ),
                    title: Text(data['email']),
                    subtitle: Text(data['phoneNumber']),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
