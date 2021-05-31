import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin:
            EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text(
              'Take : ${brew.sugars} sugars (s)/ strength : ${brew.strength}'),
        ),
      ),
    );
  }
}
