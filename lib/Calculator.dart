import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    '7',
    '8',
    '9',
    'DEL',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    '.',
    '0',
    '/',
    '*',
    'RESET',
    '=',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      Column(
        children: <Widget>[
          Divider(
            color: Colors.grey[900],
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height / 4.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[900],
          ),
          Expanded(

            child: Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonList[index]);
                  }
              )
          ),
          ),
        ],

      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4.0,
                spreadRadius: 0.3,
                offset: Offset(-3, -3),
              ),
            ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getBgColor(String text) {
    if (
        text == "7" || text == "8" || text == "9"
        || text == "4" || text == "5" || text == "6"
        || text == "1" || text == "2" || text == "3"
        || text == "." || text == "0" || text == "/"
        || text == "+" || text == "-" || text == "*") {
      return Color.fromARGB(100, 100, 100, 100);
    }
    if (
       text == "="
    ){
      return Colors.orange;
    }
    return Colors.blue;
  }

  getColor(String text) {
    if (text == "RESET" || text == "DEL" || text == "=") {
      return Color.fromARGB(1000, 100, 100, 100);
    }
    return Colors.black;
  }


  handleButtons(String text) {
    if (text == "RESET") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "DEL") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      }
      if (text == "." || text == "/" || text == "*" ){
        if (userInput.endsWith(".")){
          userInput = userInput.substring(1, userInput.length.truncate(), );
        }
      }
      else {
        return null;
      }
    }

    if(text == "="){
      result = calculate();
      userInput = result;
      if(userInput.endsWith(".0")){
        return userInput = result.replaceAll(".0", "");
        return;
      }
      if(result.endsWith(".0")){
        return result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput = userInput + text;
  }
String calculate() {
  try {
    var exp = Parser().parse(userInput);
    var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
    return evaluation.toString();
  }
  catch(e) {
    return "Error";
  }
}
}
