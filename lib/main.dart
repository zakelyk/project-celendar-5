import 'package:celendar/app/modules/home/controllers/notification_handler.dart';
import 'package:celendar/app/modules/home/views/login.dart';  //modul 4
import 'package:celendar/app/modules/home/views/register.dart'; //modul 4
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/home/controllers/note_controller.dart';
import 'package:celendar/app/modules/home/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/modules/home/views/profile.dart';
import 'firebase_options.dart';
import 'app/modules/home/views/profile_settings.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  // await FirebaseMessagingHandler().initLocalNotification();
  // NotificationHandler notificationHandler = NotificationHandler();
  // await notificationHandler.initialize();
  Get.put(NoteController()); // Inisialisasi controlle

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/setings', page: () => ProfileSettingsPage()),
      ],
      theme: ThemeData.dark(),
      // home: MyHomePage(),
      // theme: ThemeData.dark(),
    );
  }
}


