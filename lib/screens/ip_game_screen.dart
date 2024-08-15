import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:math_game/widgets/text_widget.dart';
import 'package:math_game/widgets/toast_widget.dart';

class IPGameScreen extends StatefulWidget {
  List<Map<String, dynamic>> quizQuestions;

  bool isroman;

  IPGameScreen({super.key, required this.quizQuestions, this.isroman = false});

  @override
  _IPGameScreenState createState() => _IPGameScreenState();
}

class _IPGameScreenState extends State<IPGameScreen> {
  double characterPosition = 0.0;

  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  void moveLeft() {
    setState(() {
      character = 'assets/images/character2.png';
      characterPosition -= 50; // Adjust the value as needed
    });
  }

  void moveRight() {
    setState(() {
      character = 'assets/images/character.png';
      characterPosition += 50; // Adjust the value as needed
    });
  }

  bool _isAnimating = false;

  int speed = 10;

  List<int> getUniqueRandomNumbers(int count, int min, int max) {
    Random random = Random();
    Set<int> numbers = {};

    while (numbers.length < count) {
      int randomNumber = min + random.nextInt(max - min + 1);
      numbers.add(randomNumber);
    }

    List<int> sortedNumbers = numbers.toList()..sort();
    return sortedNumbers;
  }

  int life = 3;

  int number = 1;

  late AudioPlayer player = AudioPlayer();

  playAudio() async {
    player.setReleaseMode(ReleaseMode.loop);

    await player.setSource(
      AssetSource(
        'catch.mp3',
      ),
    );

    await player.resume();
  }

  String character = 'assets/images/character.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (!_moveDown) {
            setState(() {
              // Start the animation by moving the widget down
              _moveDown = true;
              _isAnimating = true;
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.85,
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
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            for (int i = 0; i < life; i++)
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 35,
                              ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            TextWidget(
                              text: 'Question $number',
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
                              child: Center(
                                child: TextWidget(
                                  text: widget.quizQuestions[index]['question'],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: moveLeft,
                          child: Container(
                            color: Colors.black.withOpacity(0.05),
                            height: 300,
                            width: MediaQuery.sizeOf(context).width / 1.90,
                          ),
                        ),
                        GestureDetector(
                          onTap: moveRight,
                          child: Container(
                            color: Colors.black.withOpacity(0.05),
                            height: 300,
                            width: MediaQuery.sizeOf(context).width / 1.90,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  key: _key1,
                  onEnd: () {
                    if (_moveDown) {
                      playAudio();
                      // Reset position to top immediately after reaching the bottom

                      setState(() {
                        _isAnimating = false;

                        if (number == 15) {
                          speed = 5;
                        } else if (number == 25) {
                          speed = 3;
                        }
                      });

                      check();
                    }
                  },
                  top: _isAnimating
                      ? MediaQuery.of(context).size.height - 150
                      : 150,
                  duration:
                      _isAnimating ? Duration(seconds: speed) : Duration.zero,
                  child: !_isAnimating
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              for (int i = 0; i < 4; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 15, bottom: i * 75),
                                  child: Text(
                                    widget.isroman
                                        ? widget.quizQuestions[index]['options']
                                            [i]
                                        : widget.quizQuestions[index]['answers']
                                            [i],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Bold',
                                      fontSize: 6,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 -
                      25 +
                      characterPosition,
                  top: 590,
                  child: Image.asset(
                    key: _key2,
                    character,
                    height: 125,
                  ),
                ),
                !_isAnimating
                    ? Center(
                        child: TextWidget(
                          text: 'Tap to Continue',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _moveDown = false;

  check() {
    try {
      // Start the downward animation again
      Future.delayed(const Duration(milliseconds: 50), () {
        if (!mounted) return;
        setState(() {
          // life--;
          _moveDown = false;

          index++;

          _isAnimating = false;

          number++;

          if (getUniqueRandomNumbers(3, 3, 25).contains(index)) {
            life--;
          }

          if (life == 0) {
            Navigator.pop(context);

            showToast('You lost! Try again');
          }

          // if (life == 0) {
          //   Navigator.pop(context);

          //   showToast('You lost! Try again');
          // }
        });
      });
    } catch (e) {
      print('stop');
      Navigator.pop(context);
    }
  }

  int index = 0;
}
