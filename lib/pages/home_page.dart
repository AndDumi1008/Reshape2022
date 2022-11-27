import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reshape/cards/activity_info_card.dart';
import 'package:reshape/client/appwrite_client.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/models/avatar_info.dart';
import 'package:appwrite/appwrite.dart';
import 'package:reshape/widgets/rs_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/rs_margins.dart';
import '../features/authentication/register_page.dart';
import '../services/api_service.dart';
import '../widgets/rs_snackbar.dart';

class HomePage extends StatefulWidget {
  final Client client;
  const HomePage({Key? key, required this.client}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AvatarInfo>? _avatarInfo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: RsMargins.standardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Choose',
                    style: RsTextStyle.mediumHighText,
                  ),
                  Text(
                    ' your master',
                    style: RsTextStyle.bigText,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: FutureBuilder<List<AvatarInfo>?>(
                future: ApiService().fetchAvatarInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AvatarInfo>?> snapshot) {
                  if (snapshot.hasData) {
                    _avatarInfo = snapshot.data;
                    return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: _avatarInfo!.length,
                      itemBuilder: (context, index) {
                        return AvatarInfoCard(
                          id: _avatarInfo![index].id,
                          name: _avatarInfo![index].name,
                          level: _avatarInfo![index].level,
                          bigUrl: _avatarInfo![index].bigUrl,
                          client: widget.client,
                        );
                      },
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: RsMargins.standardPadding,
                  right: RsMargins.standardPadding,
                  top: 20.0),
              child: RsButton(
                text: 'Log out',
                onTap: () async {
                  String authMessage =
                      await AppWriteClient.logOutUser(widget.client);
                  final prefs = await SharedPreferences.getInstance();
                  if (authMessage == 'success') {
                    if (mounted) {
                      prefs.setBool('logInState', false);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                    client: widget.client,
                                  )),
                          (route) => false);
                      showRsSnackbar(context, 'Successful log out',
                          isError: false);
                    }
                  } else {
                    if (mounted) {
                      showRsSnackbar(context, authMessage);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
