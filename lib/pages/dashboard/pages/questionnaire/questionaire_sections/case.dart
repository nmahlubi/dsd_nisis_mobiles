import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool showTerms1 = false;
  bool showTerms2 = false;
  bool showTerms3 = false;
  bool showTerms4 = false;
  bool showTerms5 = false;
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conditional Visibility with ChecklistTile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxListTile(
            title: Text('Show Terms 1'),
            controlAffinity: ListTileControlAffinity.leading,
            value: showTerms1,
            onChanged: (bool? value) {
              setState(() {
                showTerms1 = value ?? false;
              });
            },
          ),
          if (showTerms1)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionWidget(
                      question: 'Question 1: Do you like Flutter?',
                    ),
                    QuestionWidget(
                      question: 'Question 2: Are you enjoying programming?',
                    ),
                    // Add more QuestionWidgets for additional questions
                  ],
                ),
              ),
            ),
          CheckboxListTile(
            title: Text('Show Terms 2'),
            controlAffinity: ListTileControlAffinity.leading,
            value: showTerms2,
            onChanged: (bool? value) {
              setState(() {
                showTerms2 = value ?? false;
              });
            },
          ),
          if(showTerms2)
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionWidget(
                      question: 'Question 1: Do you like Flutter?',
                    ),
                    QuestionWidget(
                      question: 'Question 2: Are you enjoying programming?',
                    ),
                    // Add more QuestionWidgets for additional questions
                  ],
                ),
              ),
            ),
          CheckboxListTile(
            title: Text('Show Terms 3'),
            controlAffinity: ListTileControlAffinity.leading,
            value: showTerms3,
            onChanged: (bool? value) {
              setState(() {
                showTerms3 = value ?? false;
              });
            },
          ),
          if(showTerms3)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionWidget(
                      question: 'Question 1: Do you like Flutter?',
                    ),
                    QuestionWidget(
                      question: 'Question 2: Are you enjoying programming?',
                    ),
                    // Add more QuestionWidgets for additional questions
                  ],
                ),
              ),
            ),
          CheckboxListTile(
            title: Text('Show Terms 4'),
            controlAffinity: ListTileControlAffinity.leading,
            value: showTerms4,
            onChanged: (bool? value) {
              setState(() {
                showTerms4 = value ?? false;
              });
            },
          ),
          if(showTerms4)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionWidget(
                      question: 'Question 1: Do you like Flutter?',
                    ),
                    QuestionWidget(
                      question: 'Question 2: Are you enjoying programming?',
                    ),
                    // Add more QuestionWidgets for additional questions
                  ],
                ),
              ),
            ),
          CheckboxListTile(
            title: Text('Show Terms 5'),
            controlAffinity: ListTileControlAffinity.leading,
            value: showTerms5,
            onChanged: (bool? value) {
              setState(() {
                showTerms5 = value ?? false;
              });
            },
          ),
          if(showTerms5)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuestionWidget(
                      question: 'Question 1: Do you like Flutter?',
                    ),
                    QuestionWidget(
                      question: 'Question 2: Are you enjoying programming?',
                    ),
                    // Add more QuestionWidgets for additional questions
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final String question;

  const QuestionWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          RadioListTile<String>(
            title: Text('Yes'),
            value: 'Yes',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('No'),
            value: 'No',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Maybe'),
            value: 'Maybe',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("I Don't Know"),
            value: "I Don't Know",
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),

        ],
      ),
    );
  }
}
