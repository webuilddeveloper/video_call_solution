import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_call/menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0d0d1b), Color(0xFF282a35)],
                begin: Alignment.topCenter,
                end: Alignment.topRight,
              ),
            ), // สีเข้มด้านบน
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  /// Logo + Title

                  const Text(
                    'หมอความออนไลน์',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create an account or log in to explore our app',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 40),

                  /// 🔹 Login Card
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            /// Tabs
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         'Log In',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 16,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         'Sign Up',
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           color: Colors.grey,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Text(
                              'เข้าสู่ระบบ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),

                            const SizedBox(height: 30),

                            /// Email
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: 'ชื่อผู้ใช้',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 12),

                            /// Password
                            TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: 'รหัสผ่าน',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),

                            const SizedBox(height: 12),

                            /// Remember + Forgot
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (_) {}),
                                const Text('Remember me'),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            /// Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  login();
                                },
                                child: const Text('เข้าสู่ระบบ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                            ),

                            // const SizedBox(height: 16),

                            // const Text('or'),

                            // const SizedBox(height: 12),

                            /// Social buttons
                            // OutlinedButton.icon(
                            //   onPressed: () {},
                            //   icon: const Icon(Icons.g_mobiledata),
                            //   label: const Text('Continue with Google'),
                            // ),
                            // OutlinedButton.icon(
                            //   onPressed: () {},
                            //   icon: const Icon(Icons.facebook),
                            //   label: const Text('Continue with Facebook'),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  login() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      if (usernameController.text.toLowerCase() == 'lawyer' &&
          passwordController.text.toLowerCase() == 'lawyer') {
        storage.write(
            key: 'userType', value: usernameController.text.toLowerCase());
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MenuPage(userType: 'lawyer',),
          ),
          (Route<dynamic> route) => false,
        );
      } else if (usernameController.text.toLowerCase() == 'user' &&
          passwordController.text.toLowerCase() == 'user') {
        storage.write(
            key: 'userType', value: usernameController.text.toLowerCase());
        await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MenuPage(userType: 'user',),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.scale,
          customHeader: Icon(
            Icons.info_outline,
            color: Colors.yellow.shade700,
            size: 110,
          ),
          title: 'ไม่พบผู้ใช้',
          desc: 'ชื่อผู้ใช้งาน หรือหรัสผ่านผิด',
          btnOkText: 'ลองอีกครั้ง',
          btnCancelText: 'ยิกเลิก',
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.scale,
        customHeader: Icon(
          Icons.info_outline,
          color: Colors.yellow.shade700,
          size: 110,
        ),
        title: 'ไม่พบผู้ใช้',
        desc: 'ชื่อผู้ใช้งาน หรือหรัสผ่านผิด',
        btnOkText: 'ลองอีกครั้ง',
        btnCancelText: 'ยิกเลิก',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
