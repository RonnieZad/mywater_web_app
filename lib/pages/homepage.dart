import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mywater_web_app/constants/constants.dart';
import 'package:mywater_web_app/models/models.dart';
import 'package:mywater_web_app/pages/settings_page.dart';

import 'package:mywater_web_app/services/services.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';
import 'package:mywater_web_app/utils/extensions.dart';
import 'package:mywater_web_app/utils/screen_overlay.dart';
import 'package:mywater_web_app/utils/toast.dart';
import 'package:mywater_web_app/utils/typography.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String userEmail = LocalCacheService.read('user_email');

  ConfettiOptions options = const ConfettiOptions(
    spread: 360,
    ticks: 50,
    gravity: 0,
    decay: 0.94,
    startVelocity: 30,
    colors: [
      Color(0xffFFE400),
      Color(0xffFFBD00),
      Color(0xffE89400),
      Color(0xffFFCA6C),
      Color(0xffFDFFB8),
    ],
  );

  shoot() {
    Confetti.launch(context, options: options.copyWith(particleCount: 40, scalar: 1.2), particleBuilder: (index) => Star());
    Confetti.launch(context,
        options: options.copyWith(
          particleCount: 10,
          scalar: 0.75,
        ));
  }

  _addNewScan() {
    LocationService.determinePosition().then((currentLocation) async {
      if (currentLocation != null) {
        bool doesScanExist = await FirestoreService.checkIfUserScanExits('MW-267', userEmail);
        if (!doesScanExist) {
          // this to removed, just for testing
          FirestoreService.addScan(
              userEmail: userEmail,
              scan: ScanModel(
                  scanCodeId: 'MW-267',
                  latitude: currentLocation.latitude,
                  longitude: currentLocation.longitude,
                  scanTime: DateTime.now().toIso8601String(),
                  companyDetails: CompanyDetails(
                    companyName: 'Safeboda LTD',
                    companyShortDescription: 'Our commitment is simple; to give you safety and peace of mind wherever you go with trained, top rated, and trusted drivers at pocket friendly fares.',
                    companyLogo: 'https://ik.imagekit.io/ecjzuksxj/myWaterCompanyLogos/myWaterCompanyLogos_3yBF8GBns',
                    companyEmail: 'info@safeboda.com',
                    companyPhone: '+256765643435',
                    companyWebsite: 'www.safeboda.com',
                  ),
                  promotionDetails: PromotionDetails(
                    promotionTitle: 'Free Rides',
                    promotionShortText: 'It is here and big, ride and win amazing discounts on yout next rides with safeboda this season of up to 70%',
                    promotionRewardPoints: 100,
                    promotionLinkUrl: 'https://www.safeboda.com/rideshare',
                    promotionArtWorlUrl: 'https://ik.imagekit.io/ecjzuksxj/myWaterCampaignArtwork/myWaterCampaignArtwork_HRr0kLhR7',
                  )));
          Timer(Duration.zero, shoot);
          Timer(const Duration(milliseconds: 100), shoot);
          Timer(const Duration(milliseconds: 200), shoot);
          toast(message: 'Scan added successfully');
        } else {
          toast(message: 'You have already scanned this bottle', isFailure: true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyWaterColor.backgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          StreamBuilder<QuerySnapshot<ScanModel>>(
              stream: FirestoreService.getUserScans(userEmail: userEmail).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<ScanModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: paragraph(text: snapshot.error.toString()),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final recentScansData = snapshot.requireData;
                var totalRedeemPoints = snapshot.requireData.docs.fold(0, (old, scan) => old + scan.data().promotionDetails!.promotionRewardPoints);

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: MyWaterColor.baseColor,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset('app_logo'.toSvg, width: 30, height: 30),
                              const Spacer(),
                              IconButton(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  LucideIcons.share,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _addNewScan();

                                  // Share.share(mywaterShareUrlText);
                                },
                              ),
                              IconButton(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  LucideIcons.user,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSetingsPage()));
                                },
                              )
                            ],
                          ),
                          30.ph,
                          title(text: 'UGX $totalRedeemPoints', color: Colors.white),
                          paragraph(text: homePageMainBalanceText, color: Colors.white),
                          20.ph,
                          ActionChip(
                            shape: const StadiumBorder(side: BorderSide(color: Colors.transparent)),
                            label: label(text: 'Redeem Rewards'),
                            onPressed: () {
                              if (totalRedeemPoints < 500) {
                                toast(message: 'You have less points to redeem', isFailure: true);
                              } else {
                                ScreenOverlay.showAppSheet(context,
                                    body: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          headingBig(text: 'Redeem Rewards'),
                                          20.ph,
                                          paragraph(text: 'Reedem your rewards as airtime, data and SMS bundles.'),
                                          30.ph,
                                          SizedBox(
                                            height: 150,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[100]),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [heading(text: 'Airtime'), 10.ph, const Icon(LucideIcons.phone)],
                                                  ),
                                                )),
                                                10.pw,
                                                Expanded(
                                                    child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue[100]),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [heading(text: 'Data'), 10.ph, const Icon(LucideIcons.wifi)],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                          20.ph
                                        ],
                                      ),
                                    ));
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    20.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          heading(text: 'Recent Scans'),
                        ],
                      ),
                    ),
                    10.ph,
                    recentScansData.docs.isEmpty
                        ? paragraph(text: 'You have no recent scans')
                        : Expanded(
                            child: ListView.separated(
                              itemCount: recentScansData.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ScanModel scanData = recentScansData.docs[index].data();

                                return ListTile(
                                  leading: Image.network(
                                    scanData.companyDetails!.companyLogo,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                  title: label(
                                    text: scanData.companyDetails!.companyName,
                                  ),
                                  subtitle: paragraph(text: 'For all rides hustle-free'),
                                  trailing: const Icon(LucideIcons.arrowUpRight),
                                  onTap: () {
                                    ScreenOverlay.showAppSheet(context,
                                        body: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Row(
                                                children: [
                                                  Image.network(
                                                    scanData.companyDetails!.companyLogo,
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  10.pw,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        label(
                                                          text: scanData.companyDetails!.companyName,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              20.ph,
                                              Row(
                                                children: [const Icon(LucideIcons.mail), 10.pw, paragraph(text: scanData.companyDetails!.companyEmail)],
                                              ),
                                              10.ph,
                                              Row(
                                                children: [const Icon(LucideIcons.phone), 10.pw, paragraph(text: scanData.companyDetails!.companyPhone)],
                                              ),
                                              10.ph,
                                              Row(
                                                children: [const Icon(LucideIcons.globe), 10.pw, paragraph(text: scanData.companyDetails!.companyWebsite)],
                                              ),
                                              20.ph,
                                              const Divider(),
                                              headingBig(text: 'Promotion Details'),
                                              30.ph,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  label(text: scanData.promotionDetails!.promotionTitle),
                                                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: MyWaterColor.baseColor.withOpacity(0.2), border: Border.all(color: MyWaterColor.baseColor), borderRadius: BorderRadius.circular(20)), child: Center(child: paragraphSmall(text: 'UGX ${scanData.promotionDetails!.promotionRewardPoints} Points'))),
                                                ],
                                              ),
                                              10.ph,
                                              paragraph(text: scanData.promotionDetails!.promotionShortText),
                                              5.ph,
                                              paragraph(
                                                text: 'Learn more here ${scanData.promotionDetails!.promotionLinkUrl}',
                                              ),
                                              20.ph,
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  scanData.promotionDetails!.promotionArtWorlUrl,
                                                  width: double.infinity,
                                                  height: 230,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              30.ph,
                                            ])));
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          )
                  ],
                );
              }),
        ],
      ),
    );
  }
}
