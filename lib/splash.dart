import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:LawyerOnline/login.dart';
import 'package:LawyerOnline/menu.dart';
// import 'package:lc/menu_v2.dart';
// import 'package:lc/menu.dart';
import 'shared/api_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    _callNavigatorPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/icons/logo.png",
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          )
        ),
      ),
    );
  }

  Future<void> _callNavigatorPage() async {
    const storage = FlutterSecureStorage();
    var user = await storage.read(key: 'userType');

    if (!mounted) return;

    if (user != null && user.isNotEmpty) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => MenuPage(userType: user,)),
        (_) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }
  }
}
