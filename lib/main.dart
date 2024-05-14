import 'package:dice_keeper/create_campaign.dart';
import 'package:dice_keeper/join_campaign.dart';
import 'package:dice_keeper/login.dart';
import 'package:dice_keeper/first_access.dart';
import 'package:dice_keeper/qr_code_campaign.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        /*
          TODO: tem que ver uma forma de colocar essa AppBar
          apenas em algumas páginas e não em todas
          appBar: AppBar(),
        */
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('./assets/background.png'),
              fit: BoxFit.scaleDown,
              repeat: ImageRepeat.repeat,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.05),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: const Center(
            // child: Login(),
            // child: FirstAccess(),
            // child: JoinCampaign(),
            child: CreateCampaign(),
            // child: QRCodeCampaign(),
          ),
        ),
      ),
    );
  }
}
