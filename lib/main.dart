import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickparked/controllers/authentication_controller.dart';
import 'package:quickparked/providers/parkings_provider.dart';
import 'package:quickparked/providers/profile_picture_provider.dart';
import 'package:quickparked/providers/siblings_provider.dart';
import 'package:quickparked/themes/assets_cache.dart';
import 'package:quickparked/themes/quickparked_theme.dart';
import 'package:quickparked/views/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickparked/views/map_view.dart';

/** This file is generated by Firebase CLI*/
import 'firebase_options.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AssetsCache.startAssets();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AuthenticationController.instance.syncWithFirebase();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'quickparked_parking_available',
            channelName: 'Notificaciones de disponibilidad',
            channelDescription:
                'Notificar en caso de que un parqueadero esté disponible')
      ],
      debug: true);
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(const QuickParked());
}

class QuickParked extends StatelessWidget {
  const QuickParked({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProfilePictureProvider()),
            ChangeNotifierProvider(create: (_) => ParkingsProvider()),
            ChangeNotifierProvider(create: (_) => SiblingsProvider())
          ],
          builder: (context, _) => MaterialApp(
              theme: quickParkedThemeData,
              title: 'QuickParked',
              home: AuthenticationController.instance.isLoggedIn
                  ? const MapView()
                  : const HomeView()));
}
