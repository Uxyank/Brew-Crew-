import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return UserTile(brews[index]);
        });
  }
}

class UserTile extends StatelessWidget {
  final Brew brew;

  UserTile(this.brew);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin:
            EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
        child: ListTile(
          title: Text(brew.name),
          subtitle:
              Text('sugars : ${brew.sugars} / strength : ${brew.strength}'),
        ),
      ),
    );
  }
}
