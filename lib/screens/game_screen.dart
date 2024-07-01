import 'package:flutter/material.dart';
import 'package:math_game/widgets/text_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double characterPosition = 0.0;

  void moveLeft() {
    setState(() {
      characterPosition -= 50; // Adjust the value as needed
    });
  }

  void moveRight() {
    setState(() {
      characterPosition += 50; // Adjust the value as needed
    });
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
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          for (int i = 0; i < 3; i++)
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 45,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          TextWidget(
                            text: 'Question',
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: 'Bold',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 -
                    25 +
                    characterPosition,
                top: 500,
                child: Image.asset(
                  'assets/images/character.png',
                  height: 150,
                ),
              ),
              Positioned(
                left: 50,
                bottom: 10,
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_left),
                    iconSize: 50,
                    onPressed: moveLeft,
                  ),
                ),
              ),
              Positioned(
                right: 50,
                bottom: 10,
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_right),
                    iconSize: 50,
                    onPressed: moveRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
