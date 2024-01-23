import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SharedPreferences? preferences;

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializePreference().whenComplete(() {
        setState(() {});
      });
    });
  }

  showDialogMessage(String? message) {
    final messageDialog = ScaffoldMessenger.of(context);
    messageDialog.showSnackBar(
      SnackBar(content: Text(message!), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                child: ListView(
              children: <Widget>[
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text('Dashboard',
                                  style: TextStyle(color: Colors.green)),
                            ],
                          ),
                          Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24.0),
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.inbox,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text('Dashboard 2',
                                  style: TextStyle(color: Colors.green)),
                              Text('2',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(24.0),
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.notifications,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Text('Dashboard 3',
                                  style: TextStyle(color: Colors.blue)),
                              Text('5',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.0),
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.move_up,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                if (preferences?.getBool('supervisor') == false)
                  _buildTile(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, '/sync-manual-offline'),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text('Sync(Offline)',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(24.0),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.sync,
                                      color: Colors.white, size: 30.0),
                                )))
                          ]),
                    ),
                  ),
              ],
            ))));
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    //print('Not set yet');
                  },
            child: child));
  }
}
