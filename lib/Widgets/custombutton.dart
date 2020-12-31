import 'package:flutter/material.dart';
import 'package:EDI/theme/customtheme.dart';

Widget customButton({String label}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.greenAccent, borderRadius: BorderRadius.circular(5)),
    width: double.infinity,
    height: 50,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Center(
      child: Text(
        label,
        style: TextStyle(color: CustomTheme.darkNavy),
      ),
    ),
    padding: EdgeInsets.all(15),
  );
}