import 'package:dice_keeper/dice_roller.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: const DiceRoller(),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            Icon(Icons.new_label),
            Icon(Icons.abc_rounded),
          ],
        ),
      ),
    );
  }
}
