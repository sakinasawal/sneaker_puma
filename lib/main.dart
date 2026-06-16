import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_puma/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sneaker_puma/data/services/auth_service_controller.dart';
import 'package:sneaker_puma/ui/login/login_page.dart';
import 'package:sneaker_puma/ui/operator/viewmodel/operator_viewmodel.dart';
import 'package:sneaker_puma/ui/pages/signup_page.dart';
import 'package:sneaker_puma/ui/contract/viewmodel/contract_viewmodel.dart';
import 'models/cart.dart';
import 'firebase_options.dart';
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
        ChangeNotifierProvider(create: (_) => ContractViewModel()),
        ChangeNotifierProvider(create: (_) => OperatorViewmodel()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthServiceController(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
