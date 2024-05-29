import 'package:dice_keeper/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Keeper',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(74, 84, 140, 1),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 220, 221, 230),
          onSecondary: Colors.black87,
          error: Colors.pink,
          onError: Colors.pink,
          surface: Colors.white,
          onSurface: Colors.black87,
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(
              Color.fromRGBO(74, 84, 140, 1),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0.5,
          highlightElevation: 1,
          focusElevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: MaterialColor(
            const Color.fromARGB(255, 220, 221, 230).value,
            const <int, Color>{},
          ),
          shadowColor: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(74, 84, 140, 1),
          ),
          labelMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.4,
          ),
          displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(74, 84, 140, 1),
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(
              TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: Login(),
      ),
    );
  }
}
