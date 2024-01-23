import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/household/house_dto.dart';
import '../pages/dashboard/pages/house_hold/create_house_hold_profile.dart';
import '../pages/dashboard/pages/house_hold/house_hold_details.dart';
import 'image_widget.dart';



class ImageEnlarger extends StatefulWidget {
  @override
  _ImageEnlargerState createState() => _ImageEnlargerState();
}

class _ImageEnlargerState extends State<ImageEnlarger> {
  late final HouseHoldDto houseHoldDto;
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(
                      Colors.blue),
                  minimumSize:
                  MaterialStateProperty.all<Size>(
                    const Size(200, 50),
                  ), // Set button width and height
                ),
                onPressed: () {
                  _showCustomDialog2(context);
                },

                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Text('Add Description'),
                    SizedBox(width: 4),
                    Icon(Icons.add),
                  ],
                ),
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
  _showCustomDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Center(
                child: Text(
                  'Image Description',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE3C263) // Adjusted to provided color
                  ),
                ),
              ),
              Divider(thickness: 2, color: Colors.grey, endIndent: 10),
            ],
          ),
          content: SizedBox(
            height: 180,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (descriptionController.value.text.isEmpty)
                    ? const Text("Image description")
                    : Text('Sent Message: ${descriptionController.value.text}'),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: descriptionController,
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Enter A Message Here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),

                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(100, 50),
                        ), // Set button width and height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateHouseHoldProfile(
                            ),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(width: 8),
                          Text('Save'),
                          SizedBox(width: 4),
                          Icon(Icons.save),
                        ],
                      ),),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

