import 'package:flutter/material.dart';
import 'package:math_game/widgets/text_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double characterPosition = 0.0;

  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();

  void moveLeft() {
    _checkCollision();
    setState(() {
      characterPosition -= 50; // Adjust the value as needed
    });
  }

  void moveRight() {
    _checkCollision();
    setState(() {
      characterPosition += 50; // Adjust the value as needed
    });
  }

  bool _isAnimating = false;

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
                              child: Center(
                                child: TextWidget(
                                  text: quizQuestions[index]['question'],
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
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 -
                      25 +
                      characterPosition,
                  top: 500,
                  child: Image.asset(
                    key: _key2,
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
                AnimatedPositioned(
                  key: _key1,
                  onEnd: () {
                    if (_moveDown) {
                      // Reset position to top immediately after reaching the bottom

                      setState(() {
                        _isAnimating = false;
                      });

                      try {
                        // Start the downward animation again
                        Future.delayed(const Duration(milliseconds: 50), () {
                          setState(() {
                            _moveDown = true;

                            index++;

                            _isAnimating = true;
                          });
                        });
                      } catch (e) {
                        print('stop');
                        Navigator.pop(context);
                      }
                    }
                  },
                  top: _isAnimating
                      ? MediaQuery.of(context).size.height - 125
                      : 0,
                  duration:
                      _isAnimating ? const Duration(seconds: 3) : Duration.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            quizQuestions[index]['answers'][i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Bold',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _moveDown = false;

  void _checkCollision() {
    final RenderBox renderBox1 =
        _key1.currentContext!.findRenderObject() as RenderBox;
    final RenderBox renderBox2 =
        _key2.currentContext!.findRenderObject() as RenderBox;

    final position1 = renderBox1.localToGlobal(Offset.zero);
    final position2 = renderBox2.localToGlobal(Offset.zero);

    final size1 = renderBox1.size;
    final size2 = renderBox2.size;

    final rect1 = position1 & size1;
    final rect2 = position2 & size2;

    if (rect1.overlaps(rect2)) {
      print('Collision detected!');
    } else {
      print('No collision.');
    }
  }

  int index = 0;

  List<Map<String, dynamic>> quizQuestions = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris'
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'answers': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars'
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'answers': [
        'Harper Lee',
        'Mark Twain',
        'Ernest Hemingway',
        'F. Scott Fitzgerald'
      ],
      'correctAnswer': 'Harper Lee'
    },
    {
      'question': 'What is the largest ocean on Earth?',
      'answers': [
        'Atlantic Ocean',
        'Indian Ocean',
        'Arctic Ocean',
        'Pacific Ocean'
      ],
      'correctAnswer': 'Pacific Ocean'
    },
  ];
}
