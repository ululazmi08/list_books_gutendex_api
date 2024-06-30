import 'package:flutter/material.dart';
import 'package:test_palmcode/constant/colors.dart';

class TStyle {
  static TextStyle title = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: kColorRegTxtBlack,
    fontFamily: 'Sen',
  );
  static TextStyle  regText = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: kColorRegTxtBlack,
    fontFamily: 'Sen',
  );
  static TextStyle successTxt = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    color: kColorTxtSuccess,
    fontFamily: 'Sen',

  );
  static TextStyle introTxt = const TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 24,
    color: kColorRegTxtBlack,
    fontFamily: 'Sen',
  );
}
