import 'dart:io';

import 'package:navin_project/Models/user.dart';
import 'package:navin_project/Controller/Provider/authentication.dart';
import 'package:navin_project/Utils/media_urls.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/Utils/widgets/custom_button.dart';
import 'package:navin_project/Utils/widgets/custom_field.dart';
import 'package:navin_project/View/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

bool isPass = false;

class _EditProfileState extends State<EditProfile> {
  final TextEditingController email = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;
  bool _termsAccepted = false;
  UserModel? _userModel;
  String? _initialImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    _userModel = await authService.fetchUserProfile();
    if (_userModel != null) {
      setState(() {
        fName.text = _userModel!.firstName;
        lName.text = _userModel!.lastName;
        email.text = _userModel!.email;
        phone.text = _userModel!.phone;
        _initialImageUrl = _userModel!.photoUrl;
        print('Fetched image URL: $_initialImageUrl'); // Debugging statement
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final authService = Provider.of<AuthService>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Color textFieldFillColor =
        isDarkMode ? Colors.grey.withOpacity(0.2) : Colors.white;
    final Color textFieldBorderColor =
        isDarkMode ? Colors.grey : theme.primaryColor.withOpacity(0.2);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.10),
                SizedBox(height: height * 0.05),
                _buildTextField(
                  "First Name",
                  fName,
                  CupertinoIcons.person,
                ),
                _buildTextField(
                  "Last Name",
                  lName,
                  CupertinoIcons.person,
                ),
                _buildTextField(
                  "Email",
                  email,
                  readOnly: true,
                  CupertinoIcons.mail,
                ),
                _buildTextField(
                  "Phone",
                  phone,
                  CupertinoIcons.phone,
                ),
                _buildTextField(
                  "BIO",
                  bio,
                  CupertinoIcons.location_solid,
                ),
                GestureDetector(
                  onTap: () {
                    _updateProfile(context);
                  },
                  child: MyButton(
                    width: width,
                    height: height * 0.07,
                    title: "Update Profile",
                  ),
                ),
                SizedBox(height: width * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CustomTextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your $label';
            }
            return null;
          },
          keyboardType: TextInputType.text,
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              color: Colors.grey,
            ),
          ),
          hintText: "Enter your $label",
          controller: controller,
          action: TextInputAction.next,
        ),
        SizedBox(height: 5),
      ],
    );
  }

  void _updateProfile(BuildContext context) async {
    try {
      await Provider.of<AuthService>(context, listen: false).updateProfile(
        _profileImage,
        description.text,
        bio.text,
        fName.text,
        lName.text,
        phone.text,
      );
      print("object");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile updated')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${e.toString()}')));
    }
  }
}
