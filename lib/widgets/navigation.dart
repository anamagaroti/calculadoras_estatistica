import 'package:flutter/material.dart';

class ButtonNavigator extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ButtonNavigator({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            animationDuration: const Duration(milliseconds: 5)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
