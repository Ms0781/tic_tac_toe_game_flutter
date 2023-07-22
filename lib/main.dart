import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_game/playerScoreCard.dart';
import 'package:tic_tac_toe_game/space.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> displayElement = ["", "", "", "", "", "", "", "", ""];
  int player1Score = 0;
  int player2Score = 0;
  int draw = 0;
  bool oTurn = true;
  int fillBoxes = 0;
  int boxesFillByPlayer1 = 0;
  int boxesFillByPlayer2 = 0;
  bool isGameFinished = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return verticalLayout();
  }

  verticalLayout() {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tic Tac Toe", style: GoogleFonts.lato(fontSize: 25)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            setState((){
             displayElement = ["", "", "", "", "", "", "", "", ""];
             isGameFinished = false;
             oTurn = true;
             });
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Space(10, false),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Space(10, true),
              PlayerScoreCard("Player 1","$player1Score"),
              Space(10, true),
              PlayerScoreCard("Player 2","$player2Score"),
              Space(10, true),
              PlayerScoreCard("Draw","$draw"),
              Space(10, true),
            ],
          ),
          Space(20, false),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int position) {
                return GestureDetector(
                  onTap: () {
                    setState((){
                     if(!isGameFinished){
                       if(displayElement[position] == "X" || displayElement[position] == "O"){
                         Fluttertoast.showToast(msg: "Invalid !!",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.red,textColor: Colors.white);
                       }
                       else{
                         if(oTurn){
                           boxesFillByPlayer1++;
                           displayElement[position] = "O";
                         }
                         else{
                           boxesFillByPlayer2++;
                           displayElement[position] = "X";
                         }
                         if(boxesFillByPlayer2 >= 3 || boxesFillByPlayer1 >= 3){
                           checkTheWinner();
                         }
                         oTurn = !oTurn;
                         fillBoxes++;
                       }
                     }
                     else{
                       Fluttertoast.showToast(msg: "Game finished",toastLength: Toast.LENGTH_SHORT,backgroundColor: Colors.black,textColor: Colors.white);
                     }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      color: Colors.black,
                    ),
                    child: Center(
                        child: Text(
                      displayElement[position],
                      style: GoogleFonts.lato(fontSize: 25,color: Colors.white),
                    )),
                  ),
                );
              }),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Space(10, true),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SignIndicationOfPlayer("Player 1", "O"),
                      SignIndicationOfPlayer("Player 2", "X")
                    ],
                ),
                Space(10, true),
                Container(height: MediaQuery.of(context).size.height,width: 2,color: Colors.black, child: Text(
                  oTurn ? "Player 1 turn" : "Player 2 turn",style: const TextStyle(color: Colors.black),
                ),)
              ],
            ),
          ),
              )
          )
        ],
      ),
    );
  }

  horizontalLayout() {
    return SafeArea(
      child: Scaffold(
          body: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 3,
            color: Colors.blue,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int position) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          color: Colors.black,
                        ),
                        child: Center(
                            child: Text(
                          displayElement[position],
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    );
                  }),
            ),
          ),
        ],
      )),
    );
  }
   checkTheWinner(){
    //for rows
    if(displayElement[0] == displayElement[1] && displayElement[0] == displayElement[2] && displayElement[0] != ""){
      declareWinner(displayElement[0]);
    }
    if(displayElement[3] == displayElement[4] && displayElement[3] == displayElement[5] && displayElement[3] != ""){
      declareWinner(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      declareWinner(displayElement[6]);
    }
    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      declareWinner(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      declareWinner(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      declareWinner(displayElement[2]);
    }

    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      declareWinner(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
        declareWinner(displayElement[2]);
    }
  }

  declareWinner(String displayElement) {
      if(displayElement == "O"){
        Fluttertoast.showToast(msg: "Player 1 is Winner",toastLength: Toast.LENGTH_SHORT);
        setState((){
          player1Score++;
          isGameFinished = true;
        });
      }
      else{
        Fluttertoast.showToast(msg: "Player 2 is Winner",toastLength: Toast.LENGTH_SHORT);
        isGameFinished = true;
      }
  }

}

class SignIndicationOfPlayer extends StatelessWidget {
  final String playerName;
  final String sign;
  const SignIndicationOfPlayer(this.playerName, this.sign, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("$playerName : $sign ",style: GoogleFonts.lato(fontSize: 18),);
  }

}