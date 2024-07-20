import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:math_game/screens/second_screen.dart';
import 'package:math_game/screens/first_screen.dart';
import 'package:math_game/screens/settings_screen.dart';
import 'package:math_game/widgets/button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/background.jpg',
            ),
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await FlutterVolumeController.setVolume(100);
                      },
                      icon: const Icon(
                        Icons.volume_down,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                children: [
                  Center(
                    child: ButtonWidget(
                      radius: 100,
                      width: 200,
                      color: Colors.blue,
                      label: 'START',
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FirstScreen()));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/character.png',
                        height: 200,
                        width: 150,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
