import 'package:navin_project/Controller/Provider/authentication.dart';
import 'package:navin_project/Models/user.dart';
import 'package:navin_project/Utils/media_urls.dart';
import 'package:navin_project/Utils/theme_colors.dart';
import 'package:navin_project/View/auth/login.dart';
import 'package:navin_project/View/selection.dart';
import 'package:navin_project/View/trainer/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:navin_project/view/TeamMember/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
            create: (_) => ThemeProvider()..loadThemePreference()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Auth Demo',
            theme: themeProvider.darkTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: TeamMemberDashboard(),
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themePrefKey = 'themePref';

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themePrefKey, isDarkMode);
  }

  Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(_themePrefKey) ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffFBF7FF),
    primaryColor: const Color(0xFFE6007E),
    useMaterial3: true,
    primarySwatch: createMaterialColor(Color.fromRGBO(230, 0, 126, 1)),
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFE6007E).withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: AppConstants.primaryColor.withOpacity(0.2),
        ),
      ),
    ),
    cardColor: Colors.white,
    dividerColor: Colors.grey,
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFFE6007E),
    useMaterial3: true,
    primarySwatch: createMaterialColor(Color.fromRGBO(230, 0, 126, 1)),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff0E1116),
    iconTheme: IconThemeData(color: Color(0xFFFFC0CB)),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFFFC0CB).withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Color(0xFFFFC0CB),
        ),
      ),
    ),
    cardColor: Color(0xFF1E1E1E),
    dividerColor: Colors.white54,
  );

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    switch (authService.authState) {
      case AuthState.Authenticated:
        return FutureBuilder<UserModel?>(
          future: authService.fetchUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else if (snapshot.hasData) {
              final userRole = snapshot.data!.role;
              if (userRole == 'TeamMember') {
                return TrainerDashboard();
              } else {
                return TrainerDashboard();
              }
            } else {
              return Login();
            }
          },
        );
      case AuthState.Unauthenticated:
      default:
        return Login();
    }
  }
}

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     switch (authService.authState) {
//       case AuthState.Authenticated:
//         return Login(); // Define HomePage to navigate to after successful login
//       case AuthState.Unauthenticated:
//       default:
//         return SplashScreen();
//     }
//   }
// }

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Media.logo, // Replace with your actual logo asset path
              height: 100, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Text(
              'Bark Board',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
