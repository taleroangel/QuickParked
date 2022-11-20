import 'package:flutter/material.dart';
import 'package:quick_parked/themes/quick_parked_theme.dart';
import 'package:quick_parked/views/home_view.dart';
import 'package:firebase_core/firebase_core.dart';

/** This file is generated by Firebase CLI*/
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
      theme: quickParkedThemeData,
      title: 'QuickParked',
      home: const HomeView());
}
