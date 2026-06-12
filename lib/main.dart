import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_puma/pages/login_page.dart';
import 'package:sneaker_puma/pages/signup_page.dart';
import 'package:sneaker_puma/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sneaker_puma/services/auth_service.dart';
import 'firebase_options.dart';
import 'models/cart.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    developer.log(
      'Flutter Error',
      error: details.exception,
      stackTrace: details.stack,
      name: 'GLOBAL',
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthService(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
