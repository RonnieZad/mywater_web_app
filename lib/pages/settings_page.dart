import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mywater_web_app/constants/constants.dart';
import 'package:mywater_web_app/models/auth_model.dart';
import 'package:mywater_web_app/services/firestore_service.dart';
import 'package:mywater_web_app/services/local_cache_service.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';
import 'package:mywater_web_app/utils/extensions.dart';
import 'package:mywater_web_app/utils/typography.dart';
import 'package:share_plus/share_plus.dart';

class AccountSetingsPage extends StatefulWidget {
  const AccountSetingsPage({super.key});

  @override
  State<AccountSetingsPage> createState() => _AccountSetingsPageState();
}

class _AccountSetingsPageState extends State<AccountSetingsPage> {
  String userEmail = LocalCacheService.read('user_email');
  @override
  Widget build(BuildContext context) {
    print(userEmail);
    return Scaffold(
      backgroundColor: MyWaterColor.backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 35, 20, 10),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: MyWaterColor.baseColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(LucideIcons.arrowLeft)),
                    headingBig(text: 'Settings', color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          20.ph,
          StreamBuilder<DocumentSnapshot<AuthModel>>(
              stream: FirestoreService.getUserAuthData(userEmail: userEmail),
              builder: (context, AsyncSnapshot<DocumentSnapshot<AuthModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: paragraph(text: snapshot.error.toString()),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                AuthModel? userData = snapshot.data!.data();

                return ListTile(
                  title: label(text: 'Account'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paragraph(text: 'Phone Number ${userData!.phonenumber}'),
                      if (userData.location != null) paragraph(text: 'Location ${userData.location}'),
                      if (userData.gender != null) paragraph(text: 'Gender ${userData.gender}'),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                );
              }),
          const Divider(),
          ListTile(
            title: label(
              text: 'History',
            ),
            subtitle: paragraph(text: 'Redeem history'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          const Divider(),
          ListTile(
            title: label(
              text: 'Contact us',
            ),
            subtitle: paragraph(text: 'Reach out for help, or to learn more'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          const Divider(),
          ListTile(
            title: label(
              text: 'Share app',
            ),
            subtitle: paragraph(text: 'Invite friends and families to join MyWater and earn more rewards'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Share.share(mywaterShareUrlText);
            },
          ),
          const Spacer(),
          paragraph(text: 'MyWater App\nv1.0.0', textAlign: TextAlign.center),
          30.ph,
        ],
      ),
    );
  }
}
