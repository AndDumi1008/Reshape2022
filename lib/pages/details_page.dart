import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/models/details.dart';
import 'package:reshape/pages/home_page.dart';

import '../constants/rs_margins.dart';
import '../constants/rs_text_style.dart';
import '../services/api_service.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Details? details;

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
                details = snapshot.data;
                print(details!.backgroundUrl);
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
                                details!.bigUrl,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 18.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              height: 40,
                              width: 40,
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
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 40,
                          bottom: 12,
                          child: Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(details!.smallUrl),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, top: 35.0, right: 35.0),
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
                                '${details!.name}!',
                                style: RsTextStyle.bigText,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Level:',
                                style: RsTextStyle.smallMediumText,
                              ),
                              Text(
                                details!.level,
                                style: RsTextStyle.smallMediumText
                                    .copyWith(color: RsColors.insaneColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 15.0),
                      child: Text(
                        'Bio',
                        style: RsTextStyle.subtitleText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: RsColors.shadowColor,
                          borderRadius:
                              BorderRadius.circular(RsMargins.standardRadius),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(RsMargins.smallPadding),
                          child: Text(
                            details!.shortBio,
                            style: RsTextStyle.descriptionText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 15.0),
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
                                details!.age,
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
                                details!.age,
                                style: RsTextStyle.descriptionText,
                              ),
                            ),
                          ),
                        ],
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
