import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_call/login.dart';
import 'package:video_call/menu.dart';
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
  late Future<dynamic> futureModel;

  @override
  void initState() {
    // _callRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSplash();
  }

  _buildSplash() {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: _callTimer(2),
        )
        
        
      ),
    );
  }

  _callRead() {
    futureModel = postDio('${server}m/splash/read', {});
  }

  _callTimer(time) async {
    var duration = Duration(seconds: time);
    return Timer(duration, _callNavigatorPage);
  }

  _callNavigatorPage() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'userType');

    if (value != null && value != '') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MenuPage(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (Route<dynamic> route) => false,
      );
    }

  }
}
