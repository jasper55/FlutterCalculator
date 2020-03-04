import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int firstNumber = 0;
  int secondNumber = 0;
  double result;
  OperatorSymbol activeCalculationSymbol;
  ActionSymbol activeActionSymbol;
  VoidCallback methodCallBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Body(activeCalculationSymbol,activeActionSymbol,methodCallBack),
      ),
    );
  }

  void onNumberPressed(int number) {
    if (firstNumber == 0) {
      firstNumber = number;
    } else {
      secondNumber = number;
    }
  }

  void setActiveOperator(OperatorSymbol operatorSymbol) {
    setState(() {
      activeCalculationSymbol = operatorSymbol;
    });
  }

  void onEnterPressed() {
    setState(() {
      if (firstNumber == 0 || secondNumber == 0) {
        return;
      } else {
        switch (activeCalculationSymbol) {
          case OperatorSymbol.DIVIDE:
            result = firstNumber / secondNumber;
            break;
          case OperatorSymbol.MULTIPLY:
            result = (firstNumber * secondNumber) as double;
            break;
          case OperatorSymbol.PLUS:
            result = (firstNumber + secondNumber) as double;
            break;
          case OperatorSymbol.MINUS:
            result = (firstNumber - secondNumber) as double;
            break;
        }
      }
      updateDisplay(result.toString());
    });
  }

  void onActionPressed() {
    setState(() {
      switch (activeActionSymbol) {
        case ActionSymbol.DELETE:
          {
            if (firstNumber == 0) {
              return;
            } else if (firstNumber != 0 && secondNumber == 0) {
              return;
            } else {
              return;
            }
          }
          break;

        case ActionSymbol.CANCEL:
          firstNumber = 0;
          secondNumber = 0;
          result = 0;
          break;
        case ActionSymbol.ENTER:
          break;
      }
    });
  }
}

class Body extends StatelessWidget {
  OperatorSymbol activeCalculationSymbol;
  ActionSymbol activeActionSymbol;
  VoidCallback methodCallBack;

  Body(this.activeCalculationSymbol, this.activeActionSymbol, this.methodCallBack);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(children: <Widget>[
        ResultContainer(),
        OperatorContainer(),
        NumberContainer(methodCallBack),
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
        ResultScreen(),
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
        ActionButton(ActionSymbol.CANCEL),
        OperatorButton(OperatorSymbol.DIVIDE),
        OperatorButton(OperatorSymbol.MULTIPLY),
        ActionButton(ActionSymbol.DELETE),
      ])
    ]);
  }
}

class ResultScreen extends StatelessWidget {
  ResultScreen();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new InkWell(
          child: new Text(
        "...",
        textAlign: TextAlign.right,
      )),
    );
  }

  void updateText(int number) {}
}

class NumberContainer extends StatelessWidget {
  VoidCallback methodCallback;

  NumberContainer(this.methodCallback);


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: <Widget>[
        NumberButton(7,methodCallback),
        NumberButton(8),
        NumberButton(9),
        OperatorButton(OperatorSymbol.MINUS)
      ]),
      Row(children: <Widget>[
        NumberButton(4),
        NumberButton(5),
        NumberButton(6),
        OperatorButton(OperatorSymbol.PLUS)
      ]),
      Row(children: <Widget>[
        NumberButton(1),
        NumberButton(2),
        NumberButton(3),
        ActionButton(ActionSymbol.ENTER)
      ]),
    ]);
  }
}

class NumberButton extends StatelessWidget {
  VoidCallback methodCallback;
  final int number;

  NumberButton(this.number, this.methodCallback);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.black,
      child: new InkWell(
        child: new Text(number.toString(),
            style: TextStyle(fontSize: 30, color: Colors.white)),
        onTap: onNumberPressed,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final ActionSymbol actionSymbol;

  ActionButton(this.actionSymbol);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(actionSymbol.name,
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  final OperatorSymbol operatorSymbol;

  OperatorButton(this.operatorSymbol);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(operatorSymbol.name,
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
    );
  }
}

void updateDisplay(String text) {
//  ResultScreen.updateText(text);
}

enum OperatorSymbol { DIVIDE, MULTIPLY, PLUS, MINUS }

extension CalculationString on OperatorSymbol {
  String get name {
    String character;
    switch (this) {
      case OperatorSymbol.DIVIDE:
        character = '/';
        break;
      case OperatorSymbol.MINUS:
        character = '-';
        break;
      case OperatorSymbol.MULTIPLY:
        character = '*';
        break;
      case OperatorSymbol.PLUS:
        character = '+';
        break;
    }
    return character;
  }
}

enum ActionSymbol { ENTER, DELETE, CANCEL }

extension ActionString on ActionSymbol {
  String get name {
    String character;
    switch (this) {
      case ActionSymbol.ENTER:
        character = '=';
        break;
      case ActionSymbol.DELETE:
        character = '<-';
        break;
      case ActionSymbol.CANCEL:
        character = 'C';
        break;
    }
    return character;
  }
}
