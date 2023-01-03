import 'package:flutter/material.dart';
import 'package:signup_login/models/current_user.dart';
import 'package:signup_login/screens/authenticate/authenticate.dart';
import 'package:signup_login/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    // return Home();
  }
}
