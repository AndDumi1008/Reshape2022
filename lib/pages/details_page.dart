import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/models/details.dart';
import 'package:reshape/pages/home_page.dart';
import 'package:reshape/pages/progress_page.dart';
import 'package:reshape/widgets/rs_button.dart';
import 'package:appwrite/appwrite.dart';

import '../constants/rs_margins.dart';
import '../constants/rs_text_style.dart';
import '../services/api_service.dart';

class DetailsPage extends StatefulWidget {
  final Client client;
  final String id;
  const DetailsPage({Key? key, required this.id, required this.client})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Details? _details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Details?>(
            future: ApiService().fetchDetails(widget.id),
            builder: (BuildContext context, AsyncSnapshot<Details?> snapshot) {
              if (snapshot.hasData) {
                _details = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                _details!.backgroundUrl,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: RsMargins.mediumPadding, top: 18.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: RsMargins.backButtonSize,
                              width: RsMargins.backButtonSize,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                hoverColor: Colors.white,
                                highlightColor: Colors.white,
                                splashRadius: 10,
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(
                                        client: widget.client,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 40,
                          bottom: 12.0,
                          child: Container(
                            height: RsMargins.avatarSize,
                            width: RsMargins.avatarSize,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_details!.smallUrl),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: RsMargins.detailsBigPadding,
                            top: RsMargins.detailsBigPadding,
                            right: RsMargins.detailsBigPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome to',
                                  style: RsTextStyle.mediumHighText,
                                ),
                                Text(
                                  '${_details!.name}!',
                                  style: RsTextStyle.bigText,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Level:',
                                  style: RsTextStyle.smallMediumText,
                                ),
                                Text(
                                  _details!.level,
                                  style: RsTextStyle.smallMediumText
                                      .copyWith(color: RsColors.insaneColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: RsMargins.detailsBigPadding,
                          vertical: RsMargins.detailsMediumPadding),
                      child: Text(
                        'Bio',
                        style: RsTextStyle.subtitleText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: RsMargins.detailsBigPadding),
                      child: Container(
                        decoration: BoxDecoration(
                          color: RsColors.shadowColor,
                          borderRadius:
                              BorderRadius.circular(RsMargins.standardRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(RsMargins.smallPadding),
                          child: Text(
                            _details!.shortBio.replaceAll("Â", ""),
                            style: RsTextStyle.descriptionText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: RsMargins.detailsBigPadding,
                          vertical: RsMargins.detailsMediumPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: RsColors.shadowColor,
                              borderRadius: BorderRadius.circular(
                                  RsMargins.standardRadius),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(RsMargins.smallPadding),
                              child: Text(
                                '${_details!.age} years old',
                                style: RsTextStyle.descriptionText,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: RsColors.shadowColor,
                              borderRadius: BorderRadius.circular(
                                  RsMargins.standardRadius),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(RsMargins.smallPadding),
                              child: Text(
                                'Net worth ${_details!.netWorth}',
                                style: RsTextStyle.descriptionText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(100.0, 100.0, 100.0, 75.0),
                      child: RsButton(
                        text: 'Reshape Yourself',
                        onTap: () {
                          Account account = Account(widget.client);
                          String userName;

                          account.get().then((response) {
                            userName = response.name;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ProgressPage(
                                      userName: userName,
                                      id: widget.id,
                                      client: widget.client,
                                    )),
                                    (route) => false);
                          }).catchError((error) {
                            userName = '';
                          });
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
