import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';


class RsButton extends StatelessWidget {
  final String text;
  final bool disabled;
  final double? height;
  final bool hasSplash;
  final void Function()? onTap;

  const RsButton(
      {Key? key,
        required this.text,
        this.disabled = false,
        this.height = RsMargins.rsButtonHeight,
        this.onTap,
        this.hasSplash = true,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? () {} : onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: RsColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(RsMargins.standardRadius)),
        elevation: 0,
        animationDuration: const Duration(milliseconds: 200),
        shadowColor: Colors.transparent,
        splashFactory: hasSplash ? null : NoSplash.splashFactory,
      ),
      child: Ink(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
              minHeight: height ?? RsMargins.rsButtonHeight),
          alignment: Alignment.center,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: RsMargins.standardPadding),
            child: Text(
              text,
              style: RsTextStyle.bold.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
