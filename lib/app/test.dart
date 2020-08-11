import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String result = "0";
  int firstOperand;
  int secondOperand;
  String currentOperator;

  void numberInput(int input) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = input;
        result = firstOperand.toString();
      } else if (firstOperand != null && currentOperator == null) {
        firstOperand = firstOperand * 10 + input;
        result = firstOperand.toString();
      } else if (firstOperand != null && currentOperator != null &&
          secondOperand == null) {
        secondOperand = input;
        result = firstOperand.toString() + " " + currentOperator + " " +
            secondOperand.toString();
      } else if (firstOperand != null && currentOperator != null &&
          secondOperand != null) {
        secondOperand = secondOperand * 10 + input;
        result = firstOperand.toString() + " " + currentOperator + " " +
            secondOperand.toString();
      }
    });
  }

  void operatorInput(String operator) {
    setState(() {
      if (currentOperator != null) {
        result = "GO FUCK YOURSELF";
      } else {
        currentOperator = operator;
        result = firstOperand.toString() + " " + currentOperator;
      }
    });
  }

  void calc() {
    setState(() {
      if (secondOperand == null){
        return;
      }

      if (currentOperator == "%") {
        if (secondOperand == 0) {
          result = "NaN";
          firstOperand = null;
          secondOperand = null;
          currentOperator = null;
          return;
        } else {
          firstOperand = firstOperand ~/ secondOperand;
        }
      } else if (currentOperator == "*") {
        firstOperand = firstOperand * secondOperand;
      } else if (currentOperator == "-") {
        firstOperand = firstOperand - secondOperand;
      } else if (currentOperator == "+") {
        firstOperand = firstOperand + secondOperand;
      }
      currentOperator = null;
      secondOperand = null;
      result = firstOperand.toString();
    });
  }

  void reset() {
    setState(() {
      result = "0";
      firstOperand = null;
      secondOperand = null;
      currentOperator = null;
    });
  }

  CalcButton numberButton(int number) {
    return CalcButton(
      text: number.toString(),
      onButtonClick: () {
        numberInput(number);
      },
    );
  }

  CalcButton operatorButton(String operator) {
    return CalcButton(
      text: operator,
      onButtonClick: () {
        operatorInput(operator);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 4,
            child: ResultText(
              text: result,
            ),
          ),
          Divider(),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              numberButton(7),
              numberButton(8),
              numberButton(9),
              operatorButton("%"),
              numberButton(4),
              numberButton(5),
              numberButton(6),
              operatorButton("*"),
              numberButton(1),
              numberButton(2),
              numberButton(3),
              operatorButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: AspectRatio(
                    aspectRatio: 2,
                    child: numberButton(0)
                ),
                flex: 2,
              ),
              Flexible(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: CalcButton(
                      text: "=",
                      backgroundColor: Colors.blue,
                      onButtonClick: calc,
                    )),
                flex: 1,
              ),
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: operatorButton(
                    "+",
                  ),
                ),
                flex: 1,)
            ],
          ),
          AspectRatio(
            child: Center(
              child: CalcButton(
                text: "AC",
                backgroundColor: Colors.red,
                onButtonClick: () {
                  reset();
                },
              ),
            ),
            aspectRatio: 6,
          )
        ],
      ),
    );
  }
}

class CalcButton extends StatelessWidget {

  final String text;
  final Color backgroundColor;
  final VoidCallback onButtonClick;

  const CalcButton({Key key, this.text, this.backgroundColor = Colors
      .transparent, this.onButtonClick,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: onButtonClick,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

class ResultText extends StatelessWidget {

  final String text;

  const ResultText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 20),
    );
  }
}