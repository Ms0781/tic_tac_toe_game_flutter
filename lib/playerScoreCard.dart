import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerScoreCard extends StatelessWidget {
  final String playerName;
  final String playScore;


  const PlayerScoreCard(this.playerName, this.playScore, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                fit : FlexFit.tight,
                child: Center(
                  child: AutoSizeText(
                    "0",
                    style: GoogleFonts.lato(
                      fontSize: 25
                    ),
                  ),
                ),
              ),
              AutoSizeText(
                playerName,
                style: GoogleFonts.lato(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
