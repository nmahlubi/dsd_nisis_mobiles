import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HouseHolsDetailsReferrals extends StatefulWidget {
  const HouseHolsDetailsReferrals({super.key});

  @override
  State<HouseHolsDetailsReferrals> createState() => _HouseHolsDetailsReferralsState();
}

class _HouseHolsDetailsReferralsState extends State<HouseHolsDetailsReferrals> {



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE3C263),
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
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
                  'https://cdn.contactcenterworld.com/images/company/department-of-social-development-1200px-logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {

                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(
                                      0xFFE3C263) // Adjusted to provided blue color
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black // Adjusted text color to white
                              ),
                            ),
                            child: const Text('Close'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Container(
                              //   margin: const EdgeInsets.only(left: 100.0),
                              //   child: Text(
                              //     'Logged in as: ${preferences?.getString('firstname')}',
                              //     style: const TextStyle(
                              //         fontSize: 7.0, color: Colors.black87),
                              //   ),
                              // ),
                              Container(
                                margin: const EdgeInsets.only(left: 100.0),
                                child: const Text(
                                  'Role: CDP',
                                  style: TextStyle(
                                      fontSize: 7.0, color: Colors.black87),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 100.0),
                                child: const Text(
                                  'Date:08/08/2023 11:43AM',
                                  style: TextStyle(
                                      fontSize: 7.0, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Color(
                                0xFF036FE3), // Adjusted to provided blue color
                            child: Text(
                              'PM',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                       Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: 30,
                                    color: Colors.brown[100],
                                    child: const Center(
                                        child: Text(
                                          'All Referrals ',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                           Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('Home Affairs Referrals',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),)],),
                              const SizedBox(height: 20.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Referral'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Assistance'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Request'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Is it the first application?'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Date Member previously \n applied'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('What was the outcome of \n previous application'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Service point of \n HomeAffairs previously \n applied'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Referral status'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text( "1"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( "Identity Document (ID)"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( "New Identity Document (ID)"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( "No"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("10/10/2023"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( "Still waiting for \n the feedback,I went there \n many times and still \n getting the same feedback."),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text( "Byron Place,320 Sophie \n de Bruyn St,Pretoria"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Review Manager"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 50),
                                      ), // Set button width and height
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 8),
                                        Text('Delete'),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(100, 50),
                                      ), // Set button width and height
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                        SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],),
                        ],
                      )
                    ],
                  ),
                )),
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
          ),
        ));
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
