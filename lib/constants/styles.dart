import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const primaryColor =  Color(0xFFC92C6D);
const appBackgroundColor = Color(0xff006D8F);
const myColor = Color(0xff00BFE0);



TextStyle kTitleText = GoogleFonts.acme(
  color: Colors.white,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

TextStyle kSubTitleText = GoogleFonts.alice(
  color: const Color(0xFF242224),
  fontSize: 19.0,
);



const List<String> listOfRelation = <String>[
  'Friend',
  'Partner',
  'Wife',
  'Sibling',
  'Children'
];

const List<String> listOfOccasions = <String>[
  "Valentine's Day",
  'Birthday',
  'Anniversary',
  'Retirement',
  'Special Day'
];
