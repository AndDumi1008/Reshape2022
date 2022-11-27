import 'package:flutter/material.dart';
import 'package:reshape/features/authentication/register_page.dart';
import 'package:reshape/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';

class InitialPageDecider extends StatefulWidget {
  final Client client;
  const InitialPageDecider({Key? key, required this.client}) : super(key: key);

  @override
  State<InitialPageDecider> createState() => _InitialPageDeciderState();
}

class _InitialPageDeciderState extends State<InitialPageDecider> {
  final Future<SharedPreferences> _sharedPrefs =
      SharedPreferences.getInstance();
  late Future<bool> _isUserLoggedIn;

  Future<void> _checkLogInState() async {
    final SharedPreferences prefs = await _sharedPrefs;
    final bool isUserLoggedIn = prefs.getBool('logInState') ?? false;

    setState(() {
      _isUserLoggedIn = prefs
          .setBool('logInState', isUserLoggedIn)
          .then((_) => isUserLoggedIn);
    });

    _isUserLoggedIn.then((value) => value == true ? Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => HomePage(
              client: widget.client,
            )),
            (route) => false) : Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => RegisterPage(
              client: widget.client,
            )),
            (route) => false));
  }

  @override
  void initState() {
    super.initState();

    _isUserLoggedIn = _sharedPrefs.then((SharedPreferences prefs) {
      return prefs.getBool('logInState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<bool>(
            future: _isUserLoggedIn,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    _checkLogInState();
                    return const Text('');
                  }
              }
            },
        ),
    );
  }
}
