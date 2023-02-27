import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/styles.dart';
import '../models/openai_model.dart';

class IdeasScreen extends StatelessWidget {
  GptData gptResponseData;
  IdeasScreen({super.key, required this.gptResponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor.withOpacity(0.5),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 15.0),
            child: Text(
              "Suggestions Towards AI🥳",
              style: kTitleText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              gptResponseData.choices[0].text,
              style: GoogleFonts.alice(
                color: Colors.white,
                fontSize: 19.0,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
