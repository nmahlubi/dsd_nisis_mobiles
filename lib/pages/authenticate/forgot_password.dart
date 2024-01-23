import 'package:flutter/material.dart';
import 'reset_password.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Reset',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: PasswordResetPage(),
    );
  }
}

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController _emailController = TextEditingController();

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
      body: Container(
        color: Color(0xFFFEF9F4), // Assuming this matches the body color in the image.
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
           
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       primary: Colors.white,
                              onPrimary: Colors.black,
                    ),
                    onPressed: () {},
                    child: Text('Cancel'),
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
                    onPressed: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                          );
                    },
                    child: Text('Reset Password'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
