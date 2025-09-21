import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/views/dashboard.dart';
import 'package:todoapp/views/login.dart';
import 'package:todoapp/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch the token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Token can be null if not logged in

  runApp(
    MaterialApp(
      title: 'To-Do App',
      debugShowCheckedModeBanner: false,
      initialRoute: token != null && !JwtDecoder.isExpired(token)
          ? "/dashboard"
          : "/",
      routes: {
        "/": (context) => const LoginPage(),
        "/signup": (context) => SignUp(),
        "/dashboard": (context) => Dashboard(token: token ?? ""), // Provide fallback for token
      },
    ),
  );
}


