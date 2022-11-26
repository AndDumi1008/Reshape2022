import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';

class RsTextStyle {
  static const TextStyle regular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textFieldErrorStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: RsColors.errorColor,
  );

  static const TextStyle snackbarStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
  );

  static const TextStyle medium = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bigText = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle mediumHighText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle smallMediumText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle subtitleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}