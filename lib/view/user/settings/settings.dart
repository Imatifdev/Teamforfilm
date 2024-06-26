import 'package:navin_project/View/detail_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:navin_project/Controller/Provider/authentication.dart';
import 'package:navin_project/Models/user.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/View/profile/edit_profile.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final TextEditingController email = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();

  UserModel? _userModel;

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
      });
    }
  }

  String url = 'https://demofree.sirv.com/nope-not-here.jpg?w=150';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundSvg =
        isDarkMode ? 'assets/images/Dark.svg' : 'assets/images/Light.svg';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: SvgPicture.asset(
          //     backgroundSvg,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  '${fName.text} ${lName.text}',
                  style: TextStyle(fontSize: 24),
                ).centered(),
                Text(
                  email.text,
                  style: TextStyle(fontSize: 14),
                ).centered(),
                SizedBox(height: 40),
                MyTile(
                  subtitle: "Edit your personal Information",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => EditProfile()));
                  },
                  title: "Edit Profile",
                  icon: CupertinoIcons.person,
                ),
                MyTile(
                  subtitle: "Change theme, reset password",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const DetailSettings(
                                  isUser: true,
                                )));
                  },
                  title: "UserSettings",
                  icon: CupertinoIcons.settings_solid,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          subtitle: Text(subtitle),
          onTap: onTap,
          trailing: Icon(CupertinoIcons.right_chevron),
          title: Text(title),
          leading: Icon(icon, color: AppConstants.primaryColor),
        ),
        Divider(height: 5),
      ],
    );
  }
}
