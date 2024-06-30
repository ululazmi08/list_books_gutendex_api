import 'package:flutter/material.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/typography.dart';

InputDecoration kDecorationForm = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  fillColor: kColorForm,
  filled: true,
  hintStyle: TStyle.regText.copyWith(fontSize: 16),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kColorOrange),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: kColorRed,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: kColorRed,
    ),
  ),
);
