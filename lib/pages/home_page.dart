import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reshape/cards/activity_info_card.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/models/avatar_info.dart';

import '../constants/rs_margins.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AvatarInfo>? avatarInfo = [];
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
              padding: const EdgeInsets.only(
                  top: RsMargins.standardPadding),
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
              height: MediaQuery.of(context).size.height * 0.85,
              child: FutureBuilder<List<AvatarInfo>?>(
                future: ApiService().fetchAvatarInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AvatarInfo>?> snapshot) {
                  if (snapshot.hasData) {
                    avatarInfo = snapshot.data;
                    return StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: avatarInfo!.length,
                      itemBuilder: (context, index) {
                        return AvatarInfoCard(
                            id: avatarInfo![index].id,
                            name: avatarInfo![index].name,
                            level: avatarInfo![index].level,
                            bigUrl: avatarInfo![index].bigUrl);
                      },
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
