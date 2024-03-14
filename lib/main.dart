import 'package:flutter/material.dart';

import 'package:kyc_app/MainScreen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KYC App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward().whenComplete(() {
      // Wait for animation to complete then navigate to MainScreen
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()));
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 6, 27, 1),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              opacity: _animationController.value,
              duration: const Duration(milliseconds: 500),
              child: Transform.translate(
                offset: Offset(0, 100 - (100 * _animationController.value)),
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/images/g1.png',
            width: 600,
            height: 600,
          ),
        ),
      ),
    );
  }
}
