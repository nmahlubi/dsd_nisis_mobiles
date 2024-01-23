import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_widget.dart';

class ImageEnlargerDescription extends StatefulWidget {
  const ImageEnlargerDescription({super.key});

  @override
  State<ImageEnlargerDescription> createState() => _ImageEnlargerDescriptionState();
}

class _ImageEnlargerDescriptionState extends State<ImageEnlargerDescription> {
  TextEditingController descriptionController = TextEditingController();

  bool isEnlarged = false;
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.blue),
                  minimumSize:
                  MaterialStateProperty.all<Size>(
                    const Size(100, 50),
                  ), // Set button width and height
                ),
                onPressed: () {
                  setState(() {
                    _displayDialog(context);
                  });
                },
                child: Text('Full Image'),
              ),
            ],
          ),
        ],
      );
  }

  _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 2000),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            print('Column tapped!');
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              Center(
                child:
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                  child:  ImageWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}