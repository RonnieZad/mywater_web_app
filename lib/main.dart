import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mywater_web_app/firebase_options.dart';
import 'package:mywater_web_app/pages/homepage.dart';
import 'package:mywater_web_app/pages/login_page.dart';
import 'package:mywater_web_app/services/services.dart';
import 'package:mywater_web_app/utils/color_scheme.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isUserAuthenticated = LocalCacheService.read('is_user_authenticated') ?? false;

    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      title: 'My Water',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyWaterColor.baseColor),
        useMaterial3: true,
      ),
      home: isUserAuthenticated ? const Homepage() : const LoginPage(),
    );
  }
}
