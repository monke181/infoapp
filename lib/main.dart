import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:information_app/pages/Dashboard.dart';
import 'package:information_app/pages/Login.dart';
import 'package:information_app/service/auth_service.dart';

// import 'package:information_app/pages/Login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        homeRoute: (context) => dashboard(),
        loginRoute: (context) => LoginPage(),

      },
      home: const AuthWrapper(),
    );
  }
}
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const LoginPage();
          } else {
            return dashboard();
          }
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      }
    );
  }
}
