import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';

void showRsSnackbar(BuildContext context, String message,
    {bool isError = true}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,
        style: RsTextStyle.snackbarStyle.copyWith(color: Colors.white)),
    backgroundColor: isError ? RsColors.errorColor : RsColors.passColor,
    padding: const EdgeInsets.symmetric(
        vertical: RsMargins.mediumPadding,
        horizontal: RsMargins.standardPadding),
    margin: const EdgeInsets.only(
        left: RsMargins.mediumPadding,
        right: RsMargins.mediumPadding,
        bottom: RsMargins.mediumPadding),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    behavior: SnackBarBehavior.floating,
  ));
}
