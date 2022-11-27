import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appwrite/appwrite.dart';
import 'package:reshape/pages/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client();

  client
      .setEndpoint('https://zettabyte.wiki/v1')
      .setProject('reshape_master')
      .setSelfSigned(
          status:
              true); // For self signed certificates, only use for development
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            client: client,
          )));
}

class MyApp extends StatelessWidget {
  final Client? client;
  const MyApp({super.key, this.client});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reshape',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: SplashScreenRs(
        client: client!,
      ),
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = ThemeData();
    return baseTheme.copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(baseTheme.textTheme));
  }
}
