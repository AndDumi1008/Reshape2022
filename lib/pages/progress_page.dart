import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:reshape/constants/rs_colors.dart';
import 'package:reshape/constants/rs_margins.dart';
import 'package:reshape/constants/rs_text_style.dart';
import 'package:reshape/models/details.dart';
import 'package:reshape/widgets/rs_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client/appwrite_client.dart';
import '../features/authentication/register_page.dart';
import '../services/api_service.dart';
import '../widgets/rs_button.dart';
import 'package:appwrite/appwrite.dart';

import '../widgets/rs_snackbar.dart';

class ProgressPage extends StatefulWidget {
  final String id;
  final String userName;
  final Client client;
  const ProgressPage(
      {Key? key,
      required this.userName,
      required this.id,
      required this.client})
      : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  Details? _details;
  bool _isCheckboxChecked = false;
  int _tasksCompleted = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(RsMargins.detailsBigPadding),
            child: FutureBuilder<Details?>(
                future: ApiService().fetchDetails(widget.id),
                builder:
                    (BuildContext context, AsyncSnapshot<Details?> snapshot) {
                  if (snapshot.hasData) {
                    _details = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: RsTextStyle.subtitleText,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: RsMargins.detailsBigPadding),
                          child: Text(
                            widget.userName,
                            style: RsTextStyle.mediumHighText,
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 120,
                          decoration: BoxDecoration(
                            color: RsColors.shadowColor,
                            borderRadius:
                                BorderRadius.circular(RsMargins.standardRadius),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(RsMargins.smallPadding),
                            child: Row(
                              children: [
                                const Text(
                                  'Day 1',
                                  style: RsTextStyle.mediumHighText,
                                ),
                                Image.asset(
                                  'assets/images/medal.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: RsMargins.mediumPadding),
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: RsColors.shadowColor,
                              borderRadius: BorderRadius.circular(
                                  RsMargins.standardRadius),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(RsMargins.smallPadding),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/sun.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'WakeUp at ${_details!.wakeUpTime}',
                                    style: RsTextStyle.smallMediumText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 230,
                          decoration: BoxDecoration(
                            color: RsColors.shadowColor,
                            borderRadius:
                                BorderRadius.circular(RsMargins.standardRadius),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(RsMargins.smallPadding),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/sleep.png',
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  'Go to sleep at ${_details!.sleepTime}',
                                  style: RsTextStyle.smallMediumText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: RsMargins.mediumPadding),
                          child: Text(
                            'Progress',
                            style: RsTextStyle.smallMediumText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: RsMargins.mediumPadding),
                          child: LinearProgressBar(
                            maxSteps: _details!.trainingWeek.length,
                            progressType: LinearProgressBar.progressTypeLinear,
                            currentStep: _tasksCompleted,
                            progressColor: RsColors.primaryColor,
                            backgroundColor: Colors.white,
                            minHeight: 10,
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: RsMargins.mediumPadding),
                            child: Text(
                              'Duty List',
                              style: RsTextStyle.smallMediumText,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: RsMargins.mediumPadding),
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              color: RsColors.shadowColor,
                              borderRadius: BorderRadius.circular(
                                  RsMargins.standardRadius),
                            ),
                            child: Center(
                              child: ListView.builder(
                                itemCount: _details!.trainingWeek.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return RsCheckbox(
                                    text: Text(
                                      _details!.trainingWeek[index],
                                      style: RsTextStyle.smallMediumText,
                                    ),
                                    isChecked: (bool isChecked) {
                                      setState(() {
                                        _isCheckboxChecked = isChecked;
                                        if (_isCheckboxChecked == true &&
                                            _tasksCompleted <=
                                                _details!.trainingWeek.length) {
                                          _tasksCompleted++;
                                        }
                                        if (_isCheckboxChecked == false &&
                                            _tasksCompleted >= 0) {
                                          _tasksCompleted--;
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: RsMargins.mediumPadding),
                            child: Text(
                              'How close are you to ${_details!.name} becoming',
                              style: RsTextStyle.smallMediumText,
                            )),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Divider(
                              thickness: 1,
                              color: RsColors.hardColor,
                            ),
                            Container(
                              height: RsMargins.avatarSize / 2,
                              width: RsMargins.avatarSize / 2,
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
                          ],
                        ),
                        Image.asset(
                          'assets/images/progress_graph.png',
                          height: 300,
                          width: 300,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: RsMargins.mediumPadding),
                            child: Text(
                              'Things to do: ',
                              style: RsTextStyle.smallMediumText,
                            )),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        RsMargins.standardRadius)),
                                backgroundColor: RsColors.yellowButton,
                              ),
                              child: Image.asset(
                                'assets/images/meals.png',
                                height: 40,
                                width: 60,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: RsMargins.mediumPadding),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          RsMargins.standardRadius)),
                                  backgroundColor: RsColors.purpleButton,
                                ),
                                child: Image.asset(
                                  'assets/images/books.png',
                                  height: 40,
                                  width: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: RsMargins.smallPadding),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      RsMargins.standardRadius)),
                              backgroundColor: RsColors.blueButton,
                            ),
                            child: Image.asset(
                              'assets/images/training.png',
                              height: 40,
                              width: 120,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: RsMargins.standardPadding),
                          child: RsButton(
                            text: 'Log out',
                            onTap: () async {
                              String authMessage =
                                  await AppWriteClient.logOutUser(
                                      widget.client);
                              final prefs =
                                  await SharedPreferences.getInstance();
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
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
