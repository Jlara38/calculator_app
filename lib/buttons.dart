import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final double screenWidth;
  final double screenHeight;
  final action_Pressed;

  MyButton({
    this.color,
    this.textColor,
    required this.buttonText,
    required this.screenWidth,
    required this.screenHeight,
    this.action_Pressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action_Pressed,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: screenWidth * 0.08,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
