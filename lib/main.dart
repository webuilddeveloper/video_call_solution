import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hms_room_kit/hms_room_kit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:video_call/home.dart';
import 'package:video_call/menu.dart';
import 'package:video_call/splash.dart';

void main() async{
  await initializeDateFormatting('th', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.promptTextTheme(),
        fontFamily: GoogleFonts.prompt().fontFamily,
      ),
      home: const SplashPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//        body:
//        Center(
//          child: ElevatedButton(
//            style: ButtonStyle(
//                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                    RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(8.0),
//            ))),
//            onPressed: () async => {
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => HMSPrebuilt(roomCode: "jle-wjbx-gyk")
//                ),
//              ),
//            },
//            child: const Padding(
//              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//              child: Text(
//                'Join',
//                style: TextStyle(fontSize: 20),
//              ),
//            ),
//          ),
//        ),
//      );
//   }
// }
