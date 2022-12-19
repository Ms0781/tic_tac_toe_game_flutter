import 'package:flutter/material.dart';

class Space extends StatelessWidget{
  int spaceUnits;
  bool horizontal;
  Space(this.spaceUnits, this.horizontal);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return horizontal ? SizedBox(width: spaceUnits.toDouble()): SizedBox(height: spaceUnits.toDouble(),);
  }
}