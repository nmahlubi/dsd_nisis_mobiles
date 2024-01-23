

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialog extends StatelessWidget {
   AlertDialog({super.key, required List<Widget> actions, required String title, required Column content});



  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      ElevatedButton(
        onPressed: () {
          _showCustomDialog(context);
        },
        child: Text('Show Custom Dialog'),
      ),
    );
  }
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:'',
          content: Column(
            children: <Widget>[
              Text('This is a custom dialog.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Perform an action when the button inside the dialog is pressed
                  Navigator.of(context).pop(); // Close the dialog
                  print('Button inside dialog pressed');
                },
                child: Text('Button Inside Dialog'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Perform an action when the button at the bottom of the dialog is pressed
                Navigator.of(context).pop(); // Close the dialog
                print('Button at the bottom of the dialog pressed');
              },
              child: Text('Button at Bottom'),
            ),
          ],
        );
      },
    );
  }
}

