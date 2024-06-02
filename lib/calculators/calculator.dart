import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double num1 = 0;
  double num2 = 0;
  String result = '';
  late String operator;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        num1 = 0;
        num2 = 0;
        result = '';
        operator = '';
        buttonText = '';
      }
      if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '/') {
        num1 = double.parse(result);
        operator = buttonText;
        result = '';
      } else if (buttonText == 'DEL') {
        result = result.length > 1 ? result.substring(0, result.length - 1) : '';
      } else if (buttonText == '=') {
        num2 = double.parse(result);
        if (operator == '+') {
          result = (num1 + num2).toStringAsFixed(1);
        } else if (operator == '-') {
          result = (num1 - num2).toStringAsFixed(1);
        } else if (operator == 'x') {
          result = (num1 * num2).toStringAsFixed(1);
        } else if (operator == '/') {
          result = (num1 / num2).toStringAsFixed(1);
        }
        operator = '';
      } else if (buttonText == '%') {
        num1 = double.parse(result);
        result = (num1 / 100).toStringAsFixed(1);
      } else {
        result = result == '' ? buttonText : result + buttonText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            result,
            style: const TextStyle(fontSize: 48, color: Colors.white),
          ),
          const Divider(),
          Row(
            children: [
              buildButton('C', FontWeight.w900, Colors.red, Colors.black),
              buildButton('%', FontWeight.w900, Colors.red, Colors.black),
              buildButton('x', FontWeight.w900, Colors.red, Colors.black),
              buildButton('DEL', FontWeight.w900, Colors.red, Colors.black),
            ],
          ),
          Row(
            children: [
              buildButton('1', FontWeight.normal, Colors.white, Colors.black),
              buildButton('2', FontWeight.normal, Colors.white, Colors.black),
              buildButton('3', FontWeight.normal, Colors.white, Colors.black),
              buildButton('/', FontWeight.w900, Colors.red, Colors.black)
            ],
          ),
          Row(
            children: [
              buildButton('4', FontWeight.normal, Colors.white, Colors.black),
              buildButton('5', FontWeight.normal, Colors.white, Colors.black),
              buildButton('6', FontWeight.normal, Colors.white, Colors.black),
              buildButton('-', FontWeight.w900, Colors.red, Colors.black)
            ],
          ),
          Row(
            children: [
              buildButton('7', FontWeight.normal, Colors.white, Colors.black),
              buildButton('8', FontWeight.normal, Colors.white, Colors.black),
              buildButton('9', FontWeight.normal, Colors.white, Colors.black),
              buildButton('+', FontWeight.w900, Colors.red, Colors.black)
            ],
          ),
          Row(
            children: [
              buildButton('', FontWeight.w900, Colors.red, Colors.black),
              buildButton('0', FontWeight.normal, Colors.white, Colors.black),
              buildButton('.', FontWeight.w900, Colors.red, Colors.black),
              buildButton('=', FontWeight.w900, Colors.red, Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(
    String buttonText,
    FontWeight? bold,
    Color? color,
    Color? backgroundColor,
  ) {
    return Expanded(
        child: ElevatedButton(
            onPressed: () => buttonPressed(buttonText),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey;
                  }
                  return backgroundColor;
                },
              ),
            ),
            child: Text(buttonText, style: TextStyle(fontSize: 20, fontWeight: bold!, color: color))));
  }
}
