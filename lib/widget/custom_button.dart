import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
  required Color color,
}){
  return Container(
      width: 200,
      color: color,
      child:  ElevatedButton(
          onPressed: onClick,
          child: Row(children: [
            Text(title),
            Icon(icon),
          ],)));
}