import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class IntegerExample extends StatefulWidget {

  @override
  IntegerExampleState createState() => IntegerExampleState();
}

class IntegerExampleState extends State<IntegerExample> {
  int _currentValue = 3;




  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentValue,
          minValue: 1,
          maxValue: 100,
          onChanged: (value) => setState(() {
            _currentValue = value;
          } ),
        ),
        Text('Nombre de jours estimé : $_currentValue'),
      ],
    );
  }
}