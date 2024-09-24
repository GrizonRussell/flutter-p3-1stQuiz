import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final Color color;
  final double size;
  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.size,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const StadiumBorder(),
      onPressed: () => onPressed(),
      color: color,
      child: Padding(
        padding: EdgeInsets.all(size),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}