import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_game/widgets/button_widget.dart';
import 'package:math_game/widgets/text_widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
            TextWidget(
              align: TextAlign.center,
              maxLines: 2,
              text: 'GAME\nCATEGORY',
              fontSize: 48,
              color: Colors.red,
              fontFamily: 'Bold',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: ButtonWidget(
                  fontSize: 14,
                  radius: 100,
                  color: Colors.grey,
                  label: 'ARITHMETIC\nOPERATION',
                  onPressed: () {},
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
                  label: 'ROMAN\nNUMERALS',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
