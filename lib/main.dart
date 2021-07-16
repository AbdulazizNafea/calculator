import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double num1 = 0;
  double num2 = 0;

  String result = '0';
  String finalResult = '0';

  String newOperation = '';
  String oldOperation = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: null,
      backgroundColor: Color(0xffFF282525),
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                button('C', Color(0xffFF5A5555), Color(0xffFFFFFD00), 0),
                button('+/-', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
                button('%', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
                button('/', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                button('7', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('8', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('9', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('x', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                button('6', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('5', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('4', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('-', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                button('3', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('2', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('1', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('+', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                button('.', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('0', Color(0xffFF312D2D), Color(0xffFFFFFFFF), 0),
                button('=', Color(0xffFF5A5555), Color(0xffFFFFFFFF), 1),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget button(String btnText, Color color, Color s, int buttonNum) {
    Container container;

    if (buttonNum == 0) {
      container = Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            calc(btnText);
          },
          child: Center(
            child: Text(
              btnText,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xa3ffffff),
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: color,
            onPrimary: Color(0xffC3FFFFFF),
            shadowColor: s,
          ),
        ),
      );
    } else {
      container = Container(
        height: 70,
        width: 172,
        padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            calc(btnText);
          },
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xa3ffffff),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              // side: BorderSide(color: Colors.red)
            ),
            primary: color,
            onPrimary: Color(0xffC3FFFFFF),
            shadowColor: s,
          ),
        ),
      );
    }

    return container;
  }

  void calc(btnText) {
    if (btnText == 'C') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '0';
      finalResult = '0';
      newOperation = '';
      oldOperation = '';
    } else if (newOperation == '=' && btnText == '=') {
      switch (oldOperation) {
        case '+':
          finalResult = add();
          break;

        case '-':
          finalResult = sub();
          break;

        case 'x':
          finalResult = mul();
          break;

        case '/':
          finalResult = div();
          break;
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }

      switch (newOperation) {
        case '+':
          finalResult = add();
          break;

        case '-':
          finalResult = sub();
          break;

        case 'x':
          finalResult = mul();
          break;

        case '/':
          finalResult = div();
          break;
      }

      oldOperation = newOperation;
      newOperation = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (num1 / 100).toString();
      finalResult = result;
    } else if (btnText == '+/-') {
      result.startsWith('-')
          ? result = result.substring(1)
          : result = '-' + result;
      finalResult = result;
    } else {
      if (result == '0')
        result = btnText;
      else
        result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return result;
  }

  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return result;
  }

  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return result;
  }

  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return result;
  }
}
