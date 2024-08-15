import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_game/screens/second_screen.dart';
import 'package:math_game/screens/third_screen.dart';
import 'package:math_game/widgets/button_widget.dart';
import 'package:math_game/widgets/text_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late AudioPlayer player = AudioPlayer();
  playAudio1() async {
    await player.setSource(
      AssetSource(
        'back.mp3',
      ),
    );

    await player.resume();
  }

  @override
  void initState() {
    super.initState();
    playAudio1();
  }

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
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: ButtonWidget(
                  fontSize: 14,
                  radius: 100,
                  color: Colors.grey,
                  label: 'BASIC\nNUMERACY',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SecondScreen()));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Center(
                child: ButtonWidget(
                  fontSize: 14,
                  radius: 100,
                  color: Colors.grey,
                  label: 'INTERMEDIATE\nNUMERACY',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ThirdScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
