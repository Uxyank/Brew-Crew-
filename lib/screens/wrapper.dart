import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Return either home or authenticate widget

    final user1 = Provider.of<UserOne?>(context);

    if (user1 == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
