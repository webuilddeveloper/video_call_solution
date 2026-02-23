import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WowMapAnimationPage extends StatefulWidget {
  const WowMapAnimationPage({super.key});

  @override
  State<WowMapAnimationPage> createState() =>
      _WowMapAnimationPageState();
}

class _WowMapAnimationPageState
    extends State<WowMapAnimationPage>
    with TickerProviderStateMixin {

  final MapController mapController = MapController();

  LatLng userLocation =
      const LatLng(13.736717, 100.523186);

  LatLng carLocation =
      const LatLng(13.726717, 100.513186);

  bool isSearching = false;
  bool found = false;

  late AnimationController rippleController;
  late AnimationController carController;

  late Animation<double> rippleAnimation;
  late Animation<double> carAnimation;

  @override
  void initState() {
    super.initState();

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    carAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(carController)
      ..addListener(() {
        moveCar();
      })
      ..addStatusListener((status) {
        if (status ==
            AnimationStatus.completed) {
          setState(() {
            isSearching = false;
            found = true;
          });
        }
      });
  }

  void moveCar() {

    double lat = lerpDouble(
        carLocation.latitude,
        userLocation.latitude,
        carAnimation.value)!;

    double lng = lerpDouble(
        carLocation.longitude,
        userLocation.longitude,
        carAnimation.value)!;

    setState(() {
      carLocation = LatLng(lat, lng);
    });
  }

  void startSearch() {

    setState(() {
      isSearching = true;
      found = false;
    });

    carController.forward(from: 0);
  }

  @override
  void dispose() {
    rippleController.dispose();
    carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: userLocation,
              initialZoom: 15,
            ),
            children: [

              TileLayer(
                urlTemplate:
                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName:
                'com.example.video_call',
              ),

              MarkerLayer(
                markers: [

                  Marker(
                    point: userLocation,
                    width: 150,
                    height: 150,
                    child: AnimatedBuilder(
                      animation: rippleController,
                      builder:
                          (context, child) {

                        return CustomPaint(
                          painter:
                          RipplePainter(
                            rippleController.value,
                          ),
                          child:
                          const Center(
                            child: Icon(
                              Icons.location_pin,
                              color:
                              Colors.red,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Marker(
                    point: carLocation,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.local_taxi,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),

                ],
              ),

            ],
          ),

          bottomCard(),

        ],
      ),
    );
  }

  Widget bottomCard() {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
            )
          ],
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [

            if (!isSearching && !found)
              ElevatedButton(
                onPressed: startSearch,
                child:
                const Text("โพสปัญหา"),
              ),

            if (isSearching)
              const Column(
                children: [

                  CircularProgressIndicator(),

                  SizedBox(height: 10),

                  Text(
                    "กำลังค้นหาผู้ช่วยใกล้คุณ...",
                    style: TextStyle(
                        fontSize: 18),
                  ),

                ],
              ),

            if (found)
              const Column(
                children: [

                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),

                  Text(
                    "พบผู้ช่วยแล้ว!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {

  final double value;

  RipplePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = Colors.blue
          .withOpacity(1 - value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      size.center(Offset.zero),
      value * 60,
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate) =>
      true;
}
