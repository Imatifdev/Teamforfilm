import 'package:navin_project/Controller/Provider/authentication.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/View/auth/signup.dart';
import 'package:navin_project/View/trainer/dashboard.dart';
import 'package:navin_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleSelection extends StatefulWidget {
  @override
  _RoleSelectionState createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Your Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            RoleBox(
              title: 'I\'m a Film Maker',
              selected: _selectedRole == 'FilmMaker',
              onTap: () {
                setState(() {
                  _selectedRole = 'FilmMaker';
                });
              },
            ),
            SizedBox(height: 20),
            RoleBox(
              title: 'I\'m a Team Memberr',
              selected: _selectedRole == 'TeamMember',
              onTap: () {
                setState(() {
                  _selectedRole = 'Trainer';
                });
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                updateDocumentField(_selectedRole!);
                print(_auth.currentUser!.uid);
              },

              // onTap: _selectedRole != null
              //     ? () => updateProfile(_selectedRole!)
              //     : null,
              child: MyButton(
                width: double.infinity,
                height: 50,
                title: "Confirm Your Role",
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateDocumentField(String role) async {
    try {
      // Get the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print("No user is signed in.");
        return;
      }

      String uid = currentUser.uid;

      // Reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('users_profile');

      // Query to find the document with the current user's UID
      QuerySnapshot querySnapshot =
          await collection.where('id', isEqualTo: uid).get();

      if (querySnapshot.docs.isEmpty) {
        print("No document found with the current user's UID.");
        return;
      }

      // Assuming there's only one document with the given UID
      DocumentReference documentRef = querySnapshot.docs.first.reference;

      // Update the specific field in the document
      await documentRef.update({'role': role});

      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => TrainerDashboard()));

      print("User");
    } catch (e) {
      print("Error updating document: $e");
    }
  }
}

class RoleBox extends StatelessWidget {
  final String title;

  final bool selected;
  final VoidCallback onTap;

  RoleBox({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: selected
              ? Border.all(color: AppConstants.primaryColor, width: 3)
              : Border.all(color: Colors.grey, width: 3),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.pink : Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
