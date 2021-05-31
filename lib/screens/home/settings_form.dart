import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '6';
  int _currentStrength = 1000;

  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<UserOne?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(user1!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;

            if (_currentName == '') {
              _currentName = userData.name;
            }
            if (_currentSugars == '6') {
              _currentSugars = userData.sugars;
            }
            if (_currentStrength == 1000) {
              _currentStrength = userData.strength;
            }
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _currentName,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                    onChanged: (val) {
                      setState(() => _currentName = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  // Dropdown
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    iconSize: 15.0,
                    value: userData.sugars,
                    items: sugars
                        .map((sugar) => DropdownMenuItem(
                              child: Text('$sugar sugars'),
                              value: sugar,
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _currentSugars = val!),
                  ),
                  // Slider
                  Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    label: _currentStrength.toString(),
                    value: (_currentStrength).toDouble(),
                    activeColor: Colors.brown[_currentStrength],
                    inactiveColor: Colors.brown[_currentStrength],
                    onChanged: (val) => setState(() {
                      _currentStrength = val.round();
                    }),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(user1.uid).updateUserData(
                          _currentName,
                          _currentSugars,
                          _currentStrength,
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
