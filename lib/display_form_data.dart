import 'package:flutter/material.dart';

class DisplayFormData extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final String? selectedName;

  DisplayFormData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.selectedName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Data'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Color(0xFF4A148C)),
                  title: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(name),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.phone, color: Color(0xFF4A148C)),
                  title: Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(phoneNumber),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.email, color: Color(0xFF4A148C)),
                  title: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(email),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.star, color: Color(0xFF4A148C)),
                  title: Text(
                    'Selected Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(selectedName ?? 'No name selected'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: DisplayFormData(
    name: "John Doe",
    phoneNumber: "123-456-7890",
    email: "john.doe@example.com",
    selectedName: "Jane Smith",  // Example selected name
  ),
));