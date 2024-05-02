import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notez/utils/shared_prefs.dart';
import 'package:notez/views/home_views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferenceService.init();
  await Hive.initFlutter();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      child: GetMaterialApp(
        title: 'Notez',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const NotezSplashScreenViews(),
      ),
    );
  }
}

class NotezSplashScreenViews extends StatefulWidget {
  const NotezSplashScreenViews({super.key});

  @override
  State<NotezSplashScreenViews> createState() => _NotezSplashScreenViewsState();
}

class _NotezSplashScreenViewsState extends State<NotezSplashScreenViews> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Get.off(() => const HomePageViews()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo-notes.png'),
      ),
    );
  }
}
