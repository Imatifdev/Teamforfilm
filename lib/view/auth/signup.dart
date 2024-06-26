import 'dart:io';

import 'package:navin_project/Controller/Provider/authentication.dart';
import 'package:navin_project/Utils/media_urls.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/Utils/widgets/custom_field.dart';
import 'package:navin_project/View/auth/login.dart';
import 'package:navin_project/View/selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navin_project/view/trainer/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

bool isPass = false;

class _SignupState extends State<Signup> {
  final TextEditingController email = TextEditingController();

  final TextEditingController fistName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController username = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _profileImage;
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final authService = Provider.of<AuthService>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.10,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width,
                  child: Image.asset(Media.logo),
                ),
                // DottedAvatarPicker(
                //   onImagePicked: (pickedImage) {
                //     setState(() {
                //       _profileImage = pickedImage;
                //     });
                //   },
                // ).centered(),
                SizedBox(
                  height: height * 0.05,
                ),
                const Text(
                  "Create Your Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ).centered(),
                SizedBox(
                  height: height * 0.07,
                ),
                const Text(
                  "First Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your First Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Jack",
                  controller: fistName,
                  action: TextInputAction.next,
                ),
                const Text(
                  "Last Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Ball",
                  controller: lastName,
                  action: TextInputAction.next,
                ),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Address. Address is used by the trainer to plan out in person sessions and availability';
                    }
                    return null;
                  },
                  lines: 1,
                  keyboardType: TextInputType.streetAddress,
                  hintText: "abc",
                  controller: username,
                  action: TextInputAction.next,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.mail,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "example@mail.com",
                  controller: email,
                  action: TextInputAction.next,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  lines: 1,
                  obscureText: isPass,
                  icon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPass = !isPass;
                      });
                    },
                    icon: Icon(
                      isPass
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "*******",
                  controller: password,
                  action: TextInputAction.done,
                ),
                const Text(
                  "Contact",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.phone,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "+44 123321123",
                  controller: phone,
                  action: TextInputAction.next,
                ),

                // Text(
                //   "About Trainer",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // CustomTextFormField(
                //   lines: 3,
                //   keyboardType: TextInputType.streetAddress,
                //   hintText: "Write about you",
                //   controller: des,
                //   action: TextInputAction.next,
                // ),
                SizedBox(
                  height: height * 0.01,
                ),
                CheckboxListTile(
                  checkColor: AppConstants.white,
                  title: Text('I accept the terms and conditions'),
                  value: _termsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                    if (_formKey.currentState!.validate()) {
                      _signup(context, '');
                    }
                  },
                  child: MyButton(
                    width: width,
                    height: height * 0.07,
                    title: "Signup",
                  ),
                ),
                SizedBox(
                  height: width * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registered Already?",
                      style: TextStyle(
                        decorationColor: AppConstants.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            decorationColor: AppConstants.primaryColor,
                            decoration: TextDecoration.underline,
                            color: AppConstants.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.grey.shade300,
                        height: 36,
                      ),
                    ),
                  ),
                  const Text("OR signin with Google"),
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Divider(
                          color: Colors.grey.shade300,
                          height: 36,
                        )),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: InkWell(
                        onTap: () async {
                          try {
                            await authService.signInWithGoogle();
                            // Navigate to the home page or display a success message
                          } catch (e) {
                            // Show the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: height * 0.03,
                                width: width * 0.1,
                                fit: BoxFit.cover,
                                image: AssetImage(Media.google)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: InkWell(
                        onTap: () async {
                          try {
                            await authService.signInWithGoogle();
                            // Navigate to the home page or display a success message
                          } catch (e) {
                            // Show the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: height * 0.03,
                                width: width * 0.1,
                                fit: BoxFit.cover,
                                image: AssetImage(Media.insta)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: InkWell(
                        onTap: () async {
                          try {
                            await authService.signInWithGoogle();
                            // Navigate to the home page or display a success message
                          } catch (e) {
                            // Show the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: height * 0.03,
                                width: width * 0.1,
                                fit: BoxFit.cover,
                                image: AssetImage(Media.facebook)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
    }
  }

  void _signup(BuildContext context, String role) async {
    try {
      await Provider.of<AuthService>(context, listen: false).signUp(
          fistName.text,
          lastName.text,
          username.text,
          email.text,
          '',
          phone.text,
          _profileImage,
          '',
          '',
          '',
          password.text,
          confirmPassword.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Signup successful')));
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => RoleSelection()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${e.toString()}'),
        ),
      );
    }
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
  });

  final double width;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppConstants.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(title,
                style: AppConstants.bodyText(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }
}
