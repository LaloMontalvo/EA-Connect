import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Debe generarse
import 'screens/splash_screen.dart';
import 'screens/feed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AppConstruccion());
}

class AppConstruccion extends StatelessWidget {
  const AppConstruccion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EA CONNECT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
