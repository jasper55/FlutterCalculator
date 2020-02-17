import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key, this.title}) : super(key: key);

  final String title;
  int firstNumber;
  int secondNumber;

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Body(),
      ),
    );
  }
}


class Body extends StatelessWidget {
  Body();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(children: <Widget>[
        ResultContainer(),
        OperatorContainer(),
        NumberContainer(),
      ])
    ]);
  }
}

class ResultContainer extends StatelessWidget {
  ResultContainer();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: <Widget>[
        EditScreen(),
      ])
    ]);
  }
}

class OperatorContainer extends StatelessWidget {
  OperatorContainer();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: <Widget>[
        CalculationButton("C"),
        CalculationButton("/"),
        CalculationButton("*"),
        CalculationButton("<-"),
      ])
    ]);
  }
}

class EditScreen extends StatelessWidget {
  EditScreen();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new InkWell(
          child: new Text("0",
            textAlign: TextAlign.right,)
      ),
    );
  }
}

class NumberContainer extends StatelessWidget {

  NumberContainer();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: <Widget>[
        NumberButton(7),
        NumberButton(8),
        NumberButton(9),
        CalculationButton(OperatorSymbol.MINUS)
      ]),
      Row(children: <Widget>[
        NumberButton(4),
        NumberButton(5),
        NumberButton(6),
        CalculationButton(OperatorSymbol.PLUS)
      ]),
      Row(children: <Widget>[
        NumberButton(1),
        NumberButton(2),
        NumberButton(3),
        CalculationButton(OperatorSymbol.ENTER)
      ]),

    ]);
  }
}

class NumberButton extends StatelessWidget {
  final int number;

  NumberButton(this.number);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.black,
      child: new InkWell(
        child: new Text(number.toString(),
            style: TextStyle(
                fontSize: 30,
                color: Colors.white)
        ),
        onTap: () {},
      ),
    );
  }
}

class CalculationButton extends StatelessWidget {
  final OperatorSymbol operatorSymbol;

  CalculationButton(this.operatorSymbol);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(
            operatorSymbol.name,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black)
        ),
        onTap: () {
          onOperatorPressed(operatorSymbol);
        },
      ),
    );
  }
}

void onOperatorPressed(OperatorSymbol operatorSymbol) {
  int newValue = 0;

  switch (operatorSymbol) {
    case OperatorSymbol.DIVIDE:
      firstNumber = newValue;
      break;
    case OperatorSymbol.MULTIPLY:
      break;
    case OperatorSymbol.PLUS:
      break;
    case OperatorSymbol.MINUS:
      break;
    case OperatorSymbol.ENTER:
      break;
  }

  updateResult(newValue);
}

void updateResult(int newValue) {

}


enum ButtonType { FUNCTION, OPERATOR, INTEGER }
enum OperatorSymbol { DIVIDE, MULTIPLY, PLUS, MINUS, ENTER }

extension OperatorString on OperatorSymbol {

  String get name {
    switch (this) {
      case OperatorSymbol.DIVIDE:
        return '/';
      case OperatorSymbol.MINUS:
        return '-';
      case OperatorSymbol.MULTIPLY:
        return '*';
      case OperatorSymbol.PLUS:
        return '+';
      case OperatorSymbol.ENTER:
        return '=';
    }
  }
