import 'package:dsd_nisis_mobile/model/household/house_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../questionnaire/house_hold_questionnaire.dart';
import 'house_hold_details.dart';

class Holdhold_View_More extends StatefulWidget {
  const Holdhold_View_More({super.key});

  @override
  State<Holdhold_View_More> createState() => _Holdhold_View_MoreState();
}

class _Holdhold_View_MoreState extends State<Holdhold_View_More> {
  @override
  FocusNode _focus = FocusNode();
  SharedPreferences? preferences;
  TextEditingController _dateController = TextEditingController();

  late final HouseHoldDto houseHoldDto;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = picked.toString();
      });
    }
  }

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
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HouseholdDetails(data: {}, requestData: {},)),
                                );
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
                              child: const Text('Back'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 100.0),
                                  child: Text(
                                    'Logged in as: ${preferences?.getString('firstname')}',
                                    style: const TextStyle(
                                        fontSize: 7.0, color: Colors.black87),
                                  ),
                                ),
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
                            const Center(
                              child: Text(
                                'Household Details',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                        0xFFE3C263) // Adjusted to provided color
                                ),
                              ),
                            ),
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
                                            'Household Member(s)',
                                            style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(300, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('Add HouseHold Member'),
                                      SizedBox(width: 4),
                                      Icon(Icons.add),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Number',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text('NO ID Number'),
                                    ],
                                  ),
                                  Align(
                                    // alignment: Alignment.center,
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      child: const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 0,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'ID Status',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'verified',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue),
                                              minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                const Size(8, 8),
                                              ), // Set button width and height
                                            ),
                                            onPressed: () {},
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(width: 8),
                                                Text('verified'),
                                                SizedBox(width: 4),
                                                Icon(Icons.verified,
                                                    size: 20, color: Colors.green),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // handle button press
                                            },
                                            child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                                child: const Icon(
                                                  Icons.question_mark,
                                                  color: Colors.white,
                                                  size: 10,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    width: 300,
                                    child: const Center(
                                      child: Text(
                                        "Member Image",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 150,
                                    width: 300,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(width: 2, color: Colors.grey),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child:  Center(
                                        child: Column(
                                          children: [
                                            Image.network(
                                              'images/download.png',
                                              width: double.infinity,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        )),
                                ),
                                )],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(200, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('upload/take image'),
                                      SizedBox(width: 4),
                                      Icon(Icons.camera_alt),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Reason no ID'),
                                const SizedBox(width: 5),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: DropdownButtonFormField(
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        onChanged: (v) {},
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal, width: 1.5)),
                                          labelText: "Please select",
                                        ),
                                        items: const [
                                          DropdownMenuItem(
                                            child: Text(
                                              "Option One",
                                            ),
                                            value: "One",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Option Two",
                                            ),
                                            value: "Two",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Name'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50.0,
                                      width: 250.0,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter text',
                                            labelText: ''),
                                        controller: new TextEditingController(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Surname'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50.0,
                                      width: 250.0,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter text',
                                            labelText: ''),
                                        controller: new TextEditingController(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Birth Country'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: DropdownButtonFormField(
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        onChanged: (v) {},
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal, width: 1.5)),
                                          labelText: "Contry",
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "Country One",
                                            ),
                                            value: "One",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Country Two",
                                            ),
                                            value: "Two",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Gender'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: DropdownButtonFormField(
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        onChanged: (v) {},
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal, width: 1.5)),
                                          labelText: "Gender",
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "Male",
                                            ),
                                            value: "MALE",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Female",
                                            ),
                                            value: "FEMALE",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('DOB'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter text',
                                            labelText: ''),
                                        controller: new TextEditingController(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Age'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter text',
                                            labelText: ''),
                                        controller: new TextEditingController(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Alive'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Yes'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('DOD'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text('N/A'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text('Marital Status'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: DropdownButtonFormField(
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        onChanged: (v) {},
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal, width: 1.5)),
                                          labelText: "Marital Status",
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "Single",
                                            ),
                                            value: "Single",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Married",
                                            ),
                                            value: "Married",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Relationship'),
                                const SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 250.0,
                                      child: DropdownButtonFormField(
                                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                                        onChanged: (v) {},
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal, width: 1.5)),
                                          labelText: "Relationship",
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(
                                              "single",
                                            ),
                                            value: "single",
                                          ),
                                          DropdownMenuItem(
                                            child: Text(
                                              "Taken",
                                            ),
                                            value: "taken",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(100, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('Save'),
                                      SizedBox(width: 4),
                                      Icon(Icons.save),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID Number',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text('1832739047'),
                                    ],
                                  ),
                                  Align(
                                    // alignment: Alignment.center,
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(10),
                                      child: const VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 0,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'ID Status',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'verified HA',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue),
                                              minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                const Size(8, 8),
                                              ), // Set button width and height
                                            ),
                                            onPressed: () {},
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                SizedBox(width: 8),
                                                Text('verified'),
                                                SizedBox(width: 4),
                                                Icon(Icons.verified,
                                                    size: 20, color: Colors.green),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // handle button press
                                            },
                                            child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                                child: const Icon(
                                                  Icons.question_mark,
                                                  color: Colors.white,
                                                  size: 10,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Surname'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Age'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Siyabonga'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Mthembu'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('34'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Completed 0/8'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 200.0,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                          minimumSize:
                                          MaterialStateProperty.all<Size>(
                                            const Size(100, 40),
                                          ), // Set button width and height
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HouseHoldQuestionnaire()),
                                          );
                                        },
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(width: 8),
                                            Text('Questionnaire'),
                                            SizedBox(width: 4),
                                            Icon(Icons.arrow_forward_outlined),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Completed 0/2'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      width: 200.0,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                          minimumSize:
                                          MaterialStateProperty.all<Size>(
                                            const Size(100, 40),
                                          ), // Set button width and height
                                        ),
                                        onPressed: () {},
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text('Referals'),
                                            SizedBox(width: 4),
                                            Icon(Icons.arrow_forward_outlined),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(200, 40),
                                      ), // Set button width and height
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('View More'),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(200, 40),
                                      ), // Set button width and height
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 8),
                                        Text('Delete'),
                                        SizedBox(width: 4),
                                        Icon(Icons.delete),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize: MaterialStateProperty.all<Size>(
                                        const Size(150, 40),
                                      ), // Set button width and height
                                    ),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                        SizedBox(width: 4),
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ]),
                    )
                  ],
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
