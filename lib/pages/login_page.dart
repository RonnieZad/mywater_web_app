import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mywater_web_app/models/auth_model.dart';
import 'package:mywater_web_app/pages/homepage.dart';
import 'package:mywater_web_app/services/firestore_service.dart';
import 'package:mywater_web_app/services/services.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';
import 'package:mywater_web_app/utils/extensions.dart';
import 'package:mywater_web_app/utils/screen_overlay.dart';
import 'package:mywater_web_app/utils/toast.dart';
import 'package:mywater_web_app/utils/typography.dart';
import 'package:mywater_web_app/widgets/app_button.dart';
import 'package:mywater_web_app/widgets/app_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneOrEmailAddressController = TextEditingController();
  List<bool> isMaleSelected = [false, false];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surveryQuestionController = TextEditingController();

  _pickUserExtraInfo() {
    ScreenOverlay.showAppSheet(context, body: StatefulBuilder(builder: (context, setter) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            headingBig(text: 'Need some basic info'),
            20.ph,
            paragraph(text: 'We would love to know a little about you.'),
            30.ph,
            paragraph(text: 'What is your name'),
            10.ph,
            AppTextField(
              iconData: LucideIcons.user,
              hintText: 'Enter first name',
              textEditingController: nameController,
            ),
            20.ph,
            paragraph(text: 'How did you hear about MyWater'),
            10.ph,
            AppTextField(
              hintText: 'Where did you hear about us',
              iconData: LucideIcons.quote,
              textEditingController: surveryQuestionController,
            ),
            20.ph,
            paragraph(text: 'What is your gender'),
            10.ph,
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setter(() {
                        isMaleSelected = [false, false];
                        isMaleSelected = [true, false];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(border: isMaleSelected[0] ? Border.all(color: MyWaterColor.baseColor, width: 4) : null, borderRadius: BorderRadius.circular(10), color: Colors.blue[100]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [heading(text: 'Male'), 10.ph, const Icon(Icons.male)],
                      ),
                    ),
                  )),
                  10.pw,
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setter(() {
                        isMaleSelected = [false, false];
                        isMaleSelected = [false, true];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(border: isMaleSelected[1] ? Border.all(color: MyWaterColor.baseColor, width: 4) : null, borderRadius: BorderRadius.circular(10), color: Colors.blue[100]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [heading(text: 'Female'), 10.ph, const Icon(Icons.female)],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            30.ph,
            AppButton(
              labelText: 'Save Profile',
              action: () {
                if (nameController.text.isEmpty) {
                  toast(message: 'Fill in your name', isFailure: true);
                } else if (surveryQuestionController.text.isEmpty) {
                  toast(message: 'How did you learn about MyWater', isFailure: true);
                } else if (isMaleSelected == [false, false]) {
                  toast(message: 'What is your gender', isFailure: true);
                } else {
                  LocationService.determinePosition().then((currentLocation) async {
                    if (currentLocation != null) {
                      FirestoreService.addUser(
                          userEmail: phoneOrEmailAddressController.text,
                          user: AuthModel(
                            latitude: currentLocation.latitude,
                            longitude: currentLocation.longitude,
                            phonenumber: phoneOrEmailAddressController.text,
                            name: nameController.text,
                            gender: isMaleSelected == [true, false] ? 'Male' : 'Female',
                          ));

                      LocalCacheService.save('is_user_authenticated', true);
                      LocalCacheService.save('user_email', phoneOrEmailAddressController.text);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
                    } else {
                      Navigator.pop(context);
                      toast(message: 'Failed to determine your location', isFailure: true);
                    }
                  });
                }
              },
            ),
            20.ph,
          ],
        ),
      );
    }));
  }

  _verifyUser() {
    print(phoneOrEmailAddressController.text.length);
    if (phoneOrEmailAddressController.text.length == 9) {
      FirestoreService.checkIfUserExists(phoneOrEmailAddressController.text).then((userExists) {
        if (userExists) {
          LocalCacheService.save('is_user_authenticated', true);
          LocalCacheService.save('user_email', phoneOrEmailAddressController.text);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage()));
        } else {
          _pickUserExtraInfo();
        }
      });
    } else {
      toast(message: 'Enter correct phone number', isFailure: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyWaterColor.backgroundColor,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 1],
                      colors: [Colors.white, Colors.transparent],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    'https://ik.imagekit.io/ecjzuksxj/app_bg.jpeg',
                    height: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(bottom: -20.0, left: 0.0, right: 0.0, child: SvgPicture.asset('app_logo'.toSvg, color: MyWaterColor.baseColor, width: 60, height: 60)),
              ],
            ),
          ),
          30.ph,
          title(text: 'Welcome'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppTextField(
              textInputType: TextInputType.phone,
              iconData: LucideIcons.phone,
              hintText: 'Phone number',
              textEditingController: phoneOrEmailAddressController,
            ),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppButton(
              labelText: 'Verify Phone',
              action: _verifyUser,
            ),
          ),
          40.ph,
        ],
      ),
    );
  }
}
