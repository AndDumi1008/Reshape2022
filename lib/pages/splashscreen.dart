import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:appwrite/appwrite.dart';
import 'package:reshape/features/authentication/register_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


class SplashScreenRs extends StatelessWidget {
  final Client client;
  const SplashScreenRs({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: RegisterPage(client: client),
      duration: 5000,
      imageSize: 200,
      imageSrc: 'assets/app_icon/rs_icon_colored.jpeg',
      text: 'Reshape',
      textStyle: RsTextStyle.bigText.copyWith(color: RsColors.primaryColor),
      backgroundColor: Colors.white,
    );
  }
}
