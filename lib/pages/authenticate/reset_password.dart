import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Reset',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: ResetPasswordPage(),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
Widget build(BuildContext context) {
    return Scaffold(
             appBar: AppBar(
          backgroundColor: Color(0xFFE3C263), // Close to the color in the image
          elevation: 0, // Remove shadow
         
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://cdn.contactcenterworld.com/images/company/department-of-social-development-1200px-logo.jpg', // Replace with your logo's URL
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFFEF9F4),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
          
            SizedBox(height: 20),
            _customInputField('Email', _emailController),
            SizedBox(height: 20),
            _customInputField('Current Password', _currentPasswordController, isPassword: true),
            SizedBox(height: 20),
            _customInputField('New Password', _newPasswordController, isPassword: true),
            SizedBox(height: 20),
            _customInputField('Confirm New Password', _confirmPasswordController, isPassword: true),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.white,
                              onPrimary: Colors.black,
                    ),
                    child: Text('Cancel'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     primary: Color(0xFFE3C263), // Gold-ish color similar to the image
                                  onPrimary: Colors.black,
                    ),
                    child: Text('Reset Password'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

 Widget _customInputField(String labelText, TextEditingController controller, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }

}
