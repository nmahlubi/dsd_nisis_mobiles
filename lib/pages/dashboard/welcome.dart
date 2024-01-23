import 'package:flutter/material.dart';

import '../../navigation_drawer/navigation_drawer_menu.dart';
import '../../sessions/session.dart';
import 'pages/dashboard_page.dart';
import 'pages/setting_page.dart';
import 'pages/worklist_page.dart';

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget {
  Session session;
  WelcomePage({Key? key, required this.session, required String title})
      : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const DashboardPage(),
    const WorkListPage(),
    //const ProfilePage(),
    const SettingPage(),
    
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFE3C263), // Close to the color in the image
          elevation: 0, // Remove shadow
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              SizedBox(width: 10), // A little space between the icon and text
              Text(
                'Module > Nisis',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
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
      drawer: const NavigationDrawerMenu(),
      body: Center(
        
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
         
           BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
