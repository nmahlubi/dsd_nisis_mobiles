import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_drawer_body_item.dart';

// ignore: use_key_in_widget_constructors
class NavigationDrawerMenu extends StatefulWidget {
  const NavigationDrawerMenu({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerMenu> createState() =>
      _NavigationDrawerMenuWidgetState();
}

class _NavigationDrawerMenuWidgetState extends State<NavigationDrawerMenu> {
  SharedPreferences? preferences;

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Welcome ${preferences?.getString('firstname')}',
              style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w200,
                  fontSize: 21),
            ),
          ),
          const Divider(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Dashboard',
            onTap: () => Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
          //if (preferences?.getBool('supervisor') == true)
          createDrawerBodyItem(
            icon: Icons.inbox,
            text: 'Menu 1',
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/notification-cases'),
          ),
          //if (preferences?.getBool('supervisor') == true)
          createDrawerBodyItem(
            icon: Icons.inbox,
            text: 'Menu 2',
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/overdue-cases'),
          ),
          createDrawerBodyItem(
            icon: Icons.inbox,
            text: 'House Hold',
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/overdue-cases'),
          ),
          
          const Divider(),
          createDrawerBodyItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('App version 1.0.0.0',
                style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
