import 'package:dice_keeper/login.dart';
import 'package:dice_keeper/first_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        /*
          TODO: tem que ver uma forma de colocar essa AppBar
          apenas em algumas páginas e não em todas
          appBar: AppBar(),
        */
        body: Center(
          // child: Login(),
          child: FirstAccess(),
        ),
      ),
    );
  }
}
