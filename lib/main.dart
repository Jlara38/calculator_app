import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey),

      initialRoute: '/',
      routes: {'/': (context) => const MyHomePage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String question = "";
  String answer = "";
  bool isParen = false;

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '()',
    '0',
    '.',
    '=',
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // This list will later be used in order to later create the button.

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(icon: const Icon(Icons.menu), tooltip: 'Menu I con', onPressed: () {}),

        title: Text('Calculator', style: TextStyle(fontSize: screenWidth * 0.05)),

        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.history),
        //     tooltip: 'History',
        //     //Add more Icons here to put them after the history one
        //   ),
        // ],

        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,

        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      body: Column(
        children: [
          _createCalculationResultsWindow(screenWidth, screenHeight),
          _createCalculatorButtons(screenHeight, screenWidth),
        ],
      ),
    );
  }

  Widget _createCalculationResultsWindow(double screenWidth, double screenHeight) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              alignment: Alignment.centerRight,
              child: Text(
                question,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              alignment: Alignment.bottomRight,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[900]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createCalculatorButtons(double screenHeight, double screenWidth) {
    return Expanded(
      flex: 2,
      child: Container(
        // You can change this to change the background from the buttons
        // color: Colors.lightBlue[100],
        child: GridView.builder(
          itemCount: buttons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            // Index 0 is meant for the clearing of the entire user input
            if (index == 0) {
              return _returnClearButton(screenWidth, screenHeight, index);
            } else if (index == 1) {
              // Index 1 is whenever the user wishes to delete something.
              return _returnDelButton(screenWidth, screenHeight, index);
            } else if (index == 16) {
              // Index 16 is meant for whenever the user wants to add parentheses to their question.
              return _returnParenthesesCheck(screenWidth, screenHeight, index);
            } else if (index == 19) {
              return _returnEqualsAns(screenWidth, screenHeight, index);
            } else {
              // Otherwise the rest of the buttons will just continue to operate as usual and just add on to the question variable.
              return _clickableButtons(screenWidth, screenHeight, index);
            }
          },
        ),
      ),
    );
  }

  Widget _returnClearButton(double screenWidth, double screenHeight, int index) {
    return MyButton(
      action_Pressed: () {
        setState(() {
          isParen = false;
          question = '';
          answer = '';
        });
      },
      color: Colors.green,
      textColor: Colors.white,
      buttonText: buttons[index],
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }

  Widget _returnDelButton(double screenWidth, double screenHeight, int index) {
    return MyButton(
      action_Pressed: () {
        setState(() {
          // Check if the last character in the input is a '(' if so keep the isParen variable as false.
          if (question[question.length - 1] == '(') {
            isParen = false;
          }
          // Check if the last character in the input is a ')' if so keep the isParen variable as true.
          else if (question[question.length - 1] == ')') {
            isParen = true;
          }
          question = question.substring(0, question.length - 1);
        });
      },
      color: Colors.red,
      textColor: Colors.white,
      buttonText: buttons[index],
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }

  Widget _returnParenthesesCheck(double screenWidth, double screenHeight, int index) {
    // If the parentheses is false it means its the first time being used thus using the '(' this side of the parentheses.
    if (isParen == false) {
      return MyButton(
        action_Pressed: () {
          setState(() {
            // We go ahead and flip the bool to true for the closing paretheses and add the '('
            isParen = true;
            question += '(';
          });
        },
        color: Colors.blue,
        textColor: Colors.white,
        buttonText: buttons[index],
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );
    } else {
      // If the parentheses is true it means its ready to add the ')' closing paretheses.
      return MyButton(
        action_Pressed: () {
          setState(() {
            // We go ahead and flip the bool to false for the closing paretheses and add the ')'
            // We make our bool false so that the user can keep using the parentheses whenever they want.
            isParen = false;
            question += ')';
          });
        },
        color: Colors.blue,
        textColor: Colors.white,
        buttonText: buttons[index],
        screenWidth: screenWidth,
        screenHeight: screenHeight,
      );
    }
  }

  Widget _returnEqualsAns(double screenWidth, double screenHeight, int index) {
    return MyButton(
      action_Pressed: () {
        setState(() {
          equalPressed();
        });
      },
      color: Colors.blue,
      textColor: Colors.white,
      buttonText: buttons[index],
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }

  Widget _clickableButtons(double screenWidth, double screenHeight, int index) {
    return MyButton(
      action_Pressed: () {
        setState(() {
          question += buttons[index];
        });
      },
      buttonText: buttons[index],
      color: Colors.blue,
      textColor: Colors.white,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  void equalPressed() {
    String finalQuestion = question;

    // Creates our expression parser
    ExpressionParser p = GrammarParser();

    // Will save the parsed expression to the our exp variable.
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
