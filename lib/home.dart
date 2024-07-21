import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'form.dart'; // Import the form page
import 'display_form_data.dart'; // Import the display form data page

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  User? user;
  String userName = 'User';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _fetchUserName();
    } else {
      // If no user is logged in, redirect to '/' (login or welcome screen)
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/');
      });
    }
  }

  Future<void> _fetchUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('accounts').doc(user!.uid).get();
      setState(() {
        userName = userDoc['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName!'),
        automaticallyImplyLeading: false, // removes the back button in the application bar
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var userData = users[index].data() as Map<String, dynamic>;
              return UserListItem(
                name: userData['name'],
                phoneNumber: userData['phoneNumber'],
                emailAddress: userData['emailAddress'],
                selectedName: userData['selectedName'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class UserListItem extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String selectedName;

  const UserListItem({
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.selectedName,
  });

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!showDetails) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayFormData(
                            name: widget.name,
                            phoneNumber: widget.phoneNumber,
                            email: widget.emailAddress,
                            selectedName: widget.selectedName,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        showDetails = false;
                      });
                    }
                  },
                  child: Text(showDetails ? 'Hide Details' : 'Show Details'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.emailAddress,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            if (showDetails)
              Text(
                'Phone Number: ${widget.phoneNumber}',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}