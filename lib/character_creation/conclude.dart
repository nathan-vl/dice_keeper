import 'package:dice_keeper/room_selection.dart';
import 'package:flutter/material.dart';

class Conclude extends StatelessWidget {
  const Conclude({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 84, 140, 1),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Tudo pronto para a jogatina",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(child: Image.asset("assets/confirm_splash.png")),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoomSelection(),
                  ),
                );
              },
              child: const Text(
                "Ir para a sala",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
