import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'buttons.dart';

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

    // TextEditingController _calculationController = " ";
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // This list will later be used in order to later create the buttons
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu I con',
          onPressed: () {},
        ),

        title: Text(
          'Calculator',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
            tooltip: 'History',
            //Add more Icons here to put them after the history one
          ),
        ],

        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        foregroundColor: Colors.white,

        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      body: Column(
        children: [
          Expanded(child: Container()),
          _createCalculatorButtons(buttons,screenHeight,screenWidth),
        ],
      ),
    );
  }

  // Widget _createCalculationResultsWindow(
  //   double screenWidth,
  //   double screenHeight,
  // ) {
  //   return Container(
  //     padding: EdgeInsets.all(screenWidth * 0.04),
  //     height: screenHeight * 0.20,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(screenWidth * 0.02),
  //       border: Border.all(color: Colors.grey, width: 1),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             IconButton(
  //               onPressed: () {},
  //               icon: Icon(Icons.backspace, color: Colors.blue[200]),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _createCalculatorButtons(List<String> buttons, double screenHeight, double screenWidth) {
    return Expanded(
      flex: 2,
      child: Container(
        child: GridView.builder(
          itemCount: buttons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (BuildContext context, int index) {
            return MyButton(
              buttonText: buttons[index],
              color: Colors.blue,
              textColor: Colors.white,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            );
          },
        ),
      ),
    );
  }
}
