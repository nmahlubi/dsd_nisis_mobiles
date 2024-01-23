import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child:
      Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Border radius
        ),
        child:
        Image.network(
          'images/One.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ));

  }
}
