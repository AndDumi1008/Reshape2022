import 'package:flutter/material.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/pages/details_page.dart';
import 'package:appwrite/appwrite.dart';

class AvatarInfoCard extends StatelessWidget {
  final String id;
  final String name;
  final String level;
  final String bigUrl;
  final Client client;

  const AvatarInfoCard({
    Key? key,
    required this.id,
    required this.name,
    required this.level,
    required this.bigUrl,
    required this.client,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: RsMargins.mediumPadding,
          vertical: RsMargins.mediumPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
              DetailsPage(id: id, client: client,),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(RsMargins.standardRadius),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: RsColors.shadowColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop),
                    image: NetworkImage(
                      bigUrl,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: RsTextStyle.mediumHighText,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Level: ',
                            style: RsTextStyle.smallMediumText,
                          ),
                          Text(level,
                              style: RsTextStyle.smallMediumText.copyWith(
                                  color: level.toLowerCase() == 'insane'
                                      ? RsColors.insaneColor
                                      : level.toLowerCase() == 'easy'
                                          ? RsColors.easyColor
                                          : level.toLowerCase() == 'hard'
                                              ? RsColors.hardColor
                                              : RsColors.mediumColor))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
