import 'package:flutter/material.dart';
import 'dart:math' as math;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}
  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentNumber = '0';
  String _operand = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  bool _shouldReset = false;

  void _handleButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _currentNumber = '0';
        _operand = '';
        _firstNumber = 0;
        _secondNumber = 0;
        _shouldReset = false;
        return;
      }

      if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/' ||
           buttonText == 'sin' ||
          buttonText == 'cos' ||
          buttonText == 'tan') {
        _operand = buttonText;
        _firstNumber = double.parse(_currentNumber);
        _currentNumber = '0';
        return;
      }

      if (buttonText == '=') {
        _secondNumber = double.parse(_currentNumber);
        switch (_operand) {
          case '+':
            _currentNumber = (_firstNumber + _secondNumber).toString();
            break;
          case '-':
            _currentNumber = (_firstNumber - _secondNumber).toString();
            break;
          case '*':
            _currentNumber = (_firstNumber * _secondNumber).toString();
            break;
          case '/':
            _currentNumber = (_firstNumber / _secondNumber).toString();
            break;
            case 'sin':
            _currentNumber = math.sin(_degreesToRadians(_firstNumber)).toString();
            break;
          case 'cos':
            _currentNumber = math.cos(_degreesToRadians(_firstNumber)).toString();
            break;
          case 'tan':
            _currentNumber = math.tan(_degreesToRadians(_firstNumber)).toString();
            break;
        }
        _shouldReset = true;
        return;
      }

      if (_currentNumber == '0' || _shouldReset) {
        _currentNumber = buttonText;
        _shouldReset = false;
      } else {
        _currentNumber += buttonText;
      }

      _output = _currentNumber;
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton (
        onPressed: () => _handleButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.right,
                    controller: TextEditingController(text: _currentNumber),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '0',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('0'),
                _buildButton('C'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
          ),
         Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildButton('sin'),
                _buildButton('cos'),
                _buildButton('tan'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}