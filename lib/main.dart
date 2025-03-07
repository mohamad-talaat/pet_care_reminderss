import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/utils/notifications/notification_service.dart';
import 'package:pet_reminder/utils/themes.dart';
import 'package:pet_reminder/views/screens/home_screen.dart';
import 'package:pet_reminder/views/widgets/fade_in.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Future<void> requestPermissions() async {
  //   if (await Permission.notification.isDenied) {
  //     await Permission.notification.request();
  //   }
  // }
   final notificationService = NotificationService();

   await notificationService.initNotification();
//  await notificationService.requestPermissions();

  Get.put(TaskController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    
      debugShowCheckedModeBanner: false,
   theme: themeEnglish,
      //  defaultTransition: Transition.cupid,
      transitionDuration: const Duration(milliseconds: 300),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      locale: const Locale('ar', 'EG'),
      home: const FadeIn(
        duration: Duration(milliseconds: 800),
        child: HomeScreen(),
      ),
    );
  }
}

