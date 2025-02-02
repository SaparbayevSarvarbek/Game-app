import 'package:flutter/material.dart';
import 'package:mabc2/pages/login_page.dart';
import 'package:mabc2/view_model/login_view_model.dart';
import 'package:mabc2/view_model/registration_view_model.dart';
import 'package:mabc2/view_model/test_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),ChangeNotifierProvider(
          create: (context) => RegistrationViewModel(),
        ),ChangeNotifierProvider(
          create:(context) => TestViewModel(),
        )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
