import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final key = new GlobalKey<_CalculatorState>();
  int firstNumber;
  int secondNumber;
  String resultText = "...";
  OperatorSymbol activeOperationSymbol;
  bool firstNumberAlreadyTyped = false;

  void onNumberPressed(int input) {
    setState(() {
      if (activeOperationSymbol == null) {
        if (firstNumber == null) {
          firstNumber = input;
          resultText = firstNumber.toString();
        } else {
          firstNumber = firstNumber * 10 + input;
          resultText = firstNumber.toString();
        }
      } else {
        if (secondNumber == null) {
          secondNumber = input;
          resultText =
              "$firstNumber ${activeOperationSymbol.name} $secondNumber";
        } else {
          secondNumber = secondNumber * 10 + input;
          resultText =
              "$firstNumber ${activeOperationSymbol.name} $secondNumber";
        }
      }
    });
  }

  void setActiveOperator(OperatorSymbol operatorSymbol) {
    setState(() {
      activeOperationSymbol = operatorSymbol;
      resultText = "$firstNumber ${activeOperationSymbol.name}";
//      firstNumberAlreadyTyped = true;
    });
  }

  void onEnterPressed() {
    setState(() {
      if (firstNumber == null || secondNumber == null) {
        resultText = "Enter number";
        return;
      } else {
        switch (activeOperationSymbol) {
          case OperatorSymbol.DIVIDE:
            firstNumber = firstNumber ~/ secondNumber;
            break;
          case OperatorSymbol.MULTIPLY:
            firstNumber = firstNumber * secondNumber;
            break;
          case OperatorSymbol.PLUS:
            firstNumber = firstNumber + secondNumber;
            break;
          case OperatorSymbol.MINUS:
            firstNumber = firstNumber - secondNumber;
            break;
        }
//        firstNumberAlreadyTyped = true;
        secondNumber = null;
        resultText = firstNumber.toString();
        activeOperationSymbol = null;
      }
    });
  }

  void onActionPressed(ActionSymbol actionSymbol) {
    setState(() {
      switch (actionSymbol) {
        case ActionSymbol.DELETE:
          {
            if (firstNumber == null) {
              return;
            } else if (firstNumber != null && secondNumber == null) {
              return;
            } else {
              return;
            }
          }
          break;

        case ActionSymbol.CANCEL:
          activeOperationSymbol = null;
//          firstNumberAlreadyTyped = false;
          firstNumber = null;
          secondNumber = null;
          resultText = "...";
          break;
        case ActionSymbol.ENTER:
          return;
      }
    });
  }

  NumberButton numberButton(int number) {
    return NumberButton(
      number: number,
      onNumberPressed: () {
        onNumberPressed(number);
      },
    );
  }

  ActionButton actionButton(ActionSymbol symbol) {
    return ActionButton(
      actionSymbol: symbol,
      onActionPressed: () {
        onActionPressed(symbol);
      },
    );
  }

  EnterButton enterButton(ActionSymbol symbol) {
    return EnterButton(
      actionSymbol: symbol,
      onEnterPressed: () {
        onEnterPressed();
      },
    );
  }

  OperatorButton operatorButton(OperatorSymbol symbol) {
    return OperatorButton(
      operatorSymbol: symbol,
      onOperatorPressed: () {
        setActiveOperator(symbol);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: <Widget>[
            Flexible(
                child: AspectRatio(
              aspectRatio: 4,
              child: new Text(
                resultText.toString(),
                textAlign: TextAlign.right,
              ),
            )),
//            Row(children: <Widget>[
//              new Container(
//                padding: EdgeInsets.all(8.0),
//                child: new InkWell(
//                    child: new Text(
//                  resultText.toString(),
//                  textAlign: TextAlign.right,
//                )),
//              )
//            ])
//        ResultContainer(),
//        OperatorContainer(),
          Row(children: <Widget>[
            Flexible(
                child: AspectRatio(
                    aspectRatio: 1, child: actionButton(ActionSymbol.CANCEL))),
            Flexible(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: operatorButton(OperatorSymbol.DIVIDE))),
            Flexible(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: operatorButton(OperatorSymbol.MULTIPLY))),
            Flexible(
              child: AspectRatio(
                  aspectRatio: 1, child: actionButton(ActionSymbol.DELETE)),
            ),
          ]),
          Column(children: [
            Row(children: <Widget>[
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(7))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(8))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(9))),
              Flexible(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: operatorButton(OperatorSymbol.MINUS)),
              ),
            ]),
            Row(children: <Widget>[
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(4))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(5))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(6))),
              Flexible(
                child: AspectRatio(
                    aspectRatio: 1, child: operatorButton(OperatorSymbol.PLUS)),
              ),
            ]),
            Row(children: <Widget>[
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(1))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(2))),
              Flexible(
                  child: AspectRatio(aspectRatio: 1, child: numberButton(3))),
              Flexible(
                child: AspectRatio(
                    aspectRatio: 1, child: enterButton(ActionSymbol.ENTER)),
              ),
            ]),
          ]),
        ]));
  }
} //_Calc

class NumberButton extends StatelessWidget {
  final int number;
  final VoidCallback onNumberPressed;

  const NumberButton({
    Key key,
    this.number,
    this.onNumberPressed,
  }) : super(key: key);

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
  final VoidCallback onActionPressed;

  const ActionButton({
    Key key,
    this.actionSymbol,
    this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(actionSymbol.name,
            style: TextStyle(fontSize: 30, color: Colors.black)),
        onTap: onActionPressed,
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  final ActionSymbol actionSymbol;
  final VoidCallback onEnterPressed;

  const EnterButton({
    Key key,
    this.actionSymbol,
    this.onEnterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(actionSymbol.name,
            style: TextStyle(fontSize: 30, color: Colors.black)),
        onTap: onEnterPressed,
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  final OperatorSymbol operatorSymbol;
  final VoidCallback onOperatorPressed;

  const OperatorButton({
    Key key,
    this.operatorSymbol,
    this.onOperatorPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.green,
      child: new InkWell(
        child: new Text(operatorSymbol.name,
            style: TextStyle(fontSize: 30, color: Colors.black)),
        onTap: onOperatorPressed,
      ),
    );
  }
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

//class ResultContainer extends StatelessWidget {
//  ResultContainer();
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: [
//      Row(children: <Widget>[
//        ResultScreen(),
//      ])
//    ]);
//  }
//}
//
//
//
//class ResultScreen extends StatelessWidget {
//  ResultScreen();
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      padding: EdgeInsets.all(8.0),
//      child: new InkWell(
//          child: new Text(
//            "...",
//            textAlign: TextAlign.right,
//          )),
//    );
//  }
//
//  void updateText(int number) {}
//}

//class NumberContainer extends StatelessWidget {
//  NumberContainer();
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: [
//      Row(children: <Widget>[
//        NumberButton(7),
//        NumberButton(8),
//        NumberButton(9),
//        OperatorButton(OperatorSymbol.MINUS)
//      ]),
//      Row(children: <Widget>[
//        NumberButton(4),
//        NumberButton(5),
//        NumberButton(6),
//        OperatorButton(OperatorSymbol.PLUS)
//      ]),
//      Row(children: <Widget>[
//        NumberButton(1),
//        NumberButton(2),
//        NumberButton(3),
//        ActionButton(ActionSymbol.ENTER)
//      ]),
//    ]);
//  }
//}

//class Body extends StatelessWidget {
//  Body();
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(children: [
//      Column(children: <Widget>[
//        Column(children: [
//          Row(children: <Widget>[
//            new Container(
//              padding: EdgeInsets.all(8.0),
//              child: new InkWell(
//                  child: new Text(
//                    "...",
//                    textAlign: TextAlign.right,
//                  )),
//            )
//          ])
//        ]),
////        ResultContainer(),
////        OperatorContainer(),
//        Row(children: <Widget>[
//          ActionButton(ActionSymbol.CANCEL),
//          OperatorButton(OperatorSymbol.DIVIDE),
//          OperatorButton(OperatorSymbol.MULTIPLY),
//          ActionButton(ActionSymbol.DELETE),
//        ]),
//        Column(children: [
//          Row(children: <Widget>[
//            NumberButton(7),
//            NumberButton(8),
//            NumberButton(9),
//            OperatorButton(OperatorSymbol.MINUS)
//          ]),
//          Row(children: <Widget>[
//            NumberButton(4),
//            NumberButton(5),
//            NumberButton(6),
//            OperatorButton(OperatorSymbol.PLUS)
//          ]),
//          Row(children: <Widget>[
//            NumberButton(1),
//            NumberButton(2),
//            NumberButton(3),
//            ActionButton(ActionSymbol.ENTER)
//          ]),
//        ]),
//      ])
//    ]);
//  }
//}

//class OperatorContainer extends StatelessWidget {
//  OperatorContainer();
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: [
//      Row(children: <Widget>[
//        ActionButton(ActionSymbol.CANCEL),
//        OperatorButton(OperatorSymbol.DIVIDE),
//        OperatorButton(OperatorSymbol.MULTIPLY),
//        ActionButton(ActionSymbol.DELETE),
//      ])
//    ]);
//  }
//}
