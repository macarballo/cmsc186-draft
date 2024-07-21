import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'display_form_data.dart'; // Import the DisplayFormData screen

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String email = '';
  String? selectedName;
  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    fetchNamesFromFirestore();
  }

  void fetchNamesFromFirestore() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<DropdownMenuItem<String>> items = snapshot.docs.map((doc) {
        String name = doc['name'];
        return DropdownMenuItem(
          value: name,
          child: Text(name),
        );
      }).toList();

      if (items.isEmpty) {
        items.add(DropdownMenuItem(
          value: 'No existing name yet',
          child: Text('No existing name yet'),
        ));
      }

      setState(() {
        dropdownItems = items;
      });
    } catch (e) {
      print('Error fetching names: $e');
      // Handle error fetching data from Firestore
    }
  }

  void submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Save data to Firestore
      try {
        await FirebaseFirestore.instance.collection('users').add({
          'name': name,
          'phoneNumber': phoneNumber,
          'emailAddress': email,
          'selectedName': selectedName,  // Add selectedName to Firestore
        });

        // Navigate to the DisplayFormData screen with the form data
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayFormData(
              name: name,
              phoneNumber: phoneNumber,
              email: email,
              selectedName: selectedName,
            ),
          ),
        );

      } catch (e) {
        print('Error saving data: $e');
        // Handle error saving data to Firestore
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.only(left: 50, right: 48),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.025),
              Text("User Information",
                  style: TextStyle(
                      fontSize: 30, color: Color(0xFF4A148C))),
              SizedBox(height: height * 0.05),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your name",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return "Enter valid name!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => name = value!,
              ),
              SizedBox(height: height * 0.025),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^(?:[+0]9)?[0-9]{11}$').hasMatch(value)) {
                    return "Enter valid phone number!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => phoneNumber = value!,
              ),
              SizedBox(height: height * 0.025),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your email",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter valid email!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: height * 0.025),
              DropdownButtonFormField<String>(
                value: selectedName,
                items: dropdownItems,
                onChanged: (value) {
                  setState(() {
                    selectedName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select a name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: height * 0.05),
              ElevatedButton(
                onPressed: () => submitForm(context),
                child: Text('Submit',
                    style: TextStyle(
                        fontSize: 18, color: Color(0xFF4A148C))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}