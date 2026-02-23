import 'dart:async';
import 'dart:ui';

import 'package:LawyerOnline/add-appointment.dart';
import 'package:LawyerOnline/map-card.dart';
import 'package:LawyerOnline/post-details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LawyerOnline/component/appbar.dart';
import 'package:LawyerOnline/lawyer-online-details.dart';
import 'package:LawyerOnline/lawyer-online-filter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class LawyerOnlineList extends StatefulWidget {
  const LawyerOnlineList({super.key});

  @override
  State<LawyerOnlineList> createState() => _LawyerOnlineListState();
}

class _LawyerOnlineListState extends State<LawyerOnlineList>
    with TickerProviderStateMixin {
  List<dynamic> lawyerOnlineList = [
    {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "scroll": 4.8,
      "cost": "Free",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-1.png",
      "experience": "11+ years",
      "clientReviews": "60+",
      "casesWon": "148+",
      "skills": [
        "Criminal lawyer",
        "Corporate lawyer",
      ]
    },
    {
      "code": "1",
      "name": "ธนากร นิติศักดิ์",
      "scroll": 4.1,
      "cost": "Free",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-2.png",
      "experience": "19+ years",
      "clientReviews": "60+",
      "casesWon": "148+",
      "skills": [
        "Family lawyer",
        "Estate planning lawyer",
      ]
    },
    {
      "code": "2",
      "name": "พงษ์ภพ ยุติธรรม",
      "scroll": 3.9,
      "cost": "Free",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-3.png",
      "experience": "10+ years",
      "clientReviews": "60+",
      "casesWon": "148+",
      "skills": [
        "Criminal lawyer",
        "Tax lawyer",
      ]
    },
    {
      "code": "3",
      "name": "อาริย์ ศิษย์กฎหมาย",
      "scroll": 3.0,
      "cost": "200",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-4.png",
      "experience": "12+ years",
      "clientReviews": "60+",
      "casesWon": "148+",
      "skills": [
        "Tax lawyer",
      ]
    },
    {
      "code": "4",
      "name": "Sachin K",
      "scroll": 4.9,
      "cost": "1000",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-5.png",
      "experience": "20+ years",
      "clientReviews": "60+",
      "casesWon": "148+",
      "skills": [
        "Criminal lawyer",
        "Bankruptcy lawyer",
      ]
    }
  ];

  String selectTab = "0";

  List<dynamic> tab = [
    {"code": "0", "title": "หาทนายให้ฉัน"},
    {"code": "1", "title": "เลือกทนายเอง"},
  ];

  // List<Map<String, String>> postCategoryList = [
  //   {"code": "0", "title": "กฏหมายแพ่งและอาญา"},
  //   {"code": "1", "title": "กฏหมายครอบครัว"},
  //   {"code": "2", "title": "กฏหมายแรงงาน"},
  //   {"code": "3", "title": "ที่ดินและอสังหาริมทรัพย์"},
  //   {"code": "4", "title": "ธุรกิจและการค้า"},
  //   {"code": "5", "title": "แรงงานต่างด้าว"},
  //   {"code": "6", "title": "เทคโนโลยี/ออนไลน์"},
  //   {"code": "7", "title": "นักสืบ/สืบสวน"},
  // ];

  List<Map<String, String>> postCategoryList = [
    {"code": "0", "title": "คดีแพ่ง"},
    {"code": "1", "title": "คดีอาญา"},
    {"code": "2", "title": "คดีชำนาญพิเศษ"},
    {"code": "3", "title": "คดีปกครอง"},
  ];

  List<Map<String, String>> postSubCategoryList = [
    {"code": "0", "title": "คดีมโนสาเร่"},
    {"code": "1", "title": "คดีผู้บริโภค"},
    {"code": "2", "title": "คดีครอบครัว"},
    {"code": "3", "title": "คดีมรดก"},
    {"code": "4", "title": "คดีความผิดเกี่ยวกับทรัพย์"},
    {"code": "5", "title": "คดีความผิดเกี่ยวกับเพศ/ร่างกาย"},
    {"code": "6", "title": "คดีความผิดเกี่ยวกับเอกสาร/ชื่อเสียง"},
    {"code": "7", "title": "คดีอาญาทุจริตและประพฤติมิชอบ"},
  ];

  String? selectedCategory = "0";
  String? selectedSubCategory = "0";

  dynamic postModel = {
    "selectedCategory": "0",
    "selectedCategoryTitle": "คดีแพ่ง",
    "selectedSubCategory": "2",
    "selectedSubCategoryTitle": "คดีครอบครัว",
    "postText": ""
  };

  final MapController mapController = MapController();

  // LatLng currentLocation = const LatLng(13.736717, 100.523186);
  LatLng? currentLocation;

  Map<String, dynamic>? selectedLocation;

  dynamic lawyerApproveDetail = {
    "code": "0",
    "name": "ศักดิ์สิทธิ์ พิพากษ์",
    "scroll": 4.8,
    "cost": "ไม่เสียค่าใช้จ่าย",
    "costUnit": "/hr",
    "imageUrl": "assets/images/lawyer-avatar-1.png",
    "experience": "11+ years",
    "skills": [
      "Family lawyer",
      "Estate planning lawyer",
    ]
  };

  late AnimationController cardController;
  late Animation<double> cardAnimation;

  late AnimationController cardLawyerController;
  late Animation<double> cardLawyerAnimation;

  late AnimationController rippleController;
  late AnimationController carController;

  late Animation<double> rippleAnimation;
  late Animation<double> carAnimation;

  bool isSearching = false;
  bool found = false;

  bool _mapReady = false;

  LatLng carLocation = const LatLng(13.726717, 100.513186);
  LatLng userLocation = const LatLng(13.736717, 100.523186);

  Timer? timer;
  int seconds = 4;

  DateTime selectedTime = DateTime.now();
  final TextEditingController dateController = TextEditingController();

  final List<Map<String, dynamic>> locations = [
    {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "category": "กฏหมายครอบครัว",
      "story":
          "เมื่อ2ปีที่แล้ว ดิฉันได้จ้างทนายท่านนี้เพื่อทำคดีของสามีเพื่อหาวิธีสู้คดีเพราะเราบริสุทธิ์คือโดนแทนพี่ชายอ่ะคะทนายท่านนี้ได้เข้ามาเป็นทนายและมีค่าจ้างทนาย ตามใบเสร็จศาล ประมาณ150000 บาท ดิฉันไม่มีเงินก้อนเลยตกลงกันว่าจะผ่อนให้  เรื่อยๆ เเล้วแต่เค้าจะเรียก 5000 บ้าง 7000 บ้าง 1หมื่นบ้าง เป็นครั้งคราวไป ดิฉันขายขายของได้เท่าไหร่ ก็ให้เค้าหมด เพื่อหวังให้ทุกอย่าง จบ .....แต่มันไม่เป็นแบบนั้น  ศาลชั้นต้นตัดสินยืน ทนายเลยบอกให้ อุธรณ์อีกครั้ง เพราะศาลชั้นต้นอ่านจะไม่ละเอียดพอ  ระหว่างนั้นสามีดิฉันเข้าไปอยู่ในเรือนจำ รอประกันออกมา  อ่อลืมบอกไปค่ะ ตอนเเรกที่เจอทนายคนนี้เพราะเค้าโทรมาบอกว่าเป็นเจ้าของหลักทรัพย์ที่เราไปเช่ากับนายหน้า ตอนนั้นไม่มรทนายเลยให้เค้าช่วย ใจคิดแล้วว่าเป็นโชคดีของเรา",
      "createDate": "9 ชั่วโมงที่ผ่านมา",
      "lawyerApprove": true,
      "lawyerModel": {
        "code": "0",
        "name": "ศักดิ์สิทธิ์ พิพากษ์",
        "scroll": 4.8,
        "cost": "ไม่เสียค่าใช้จ่าย",
        "costUnit": "/hr",
        "imageUrl": "assets/images/lawyer-avatar-1.png",
        "experience": "11+ years",
        "skills": [
          "Family lawyer",
          "Estate planning lawyer",
        ]
      },
      "position": const LatLng(13.7466, 100.5393),
      "status": "1",
      "statusText": "กำลังดำเนินการ"
    },
    {
      "code": "2",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "category": "ที่ดินและอสังหาริมทรัพย์",
      "story":
          "เมื่อ2ปีที่แล้ว ดิฉันได้จ้างทนายท่านนี้เพื่อทำคดีของสามีเพื่อหาวิธีสู้คดีเพราะเราบริสุทธิ์คือโดนแทนพี่ชายอ่ะคะทนายท่านนี้ได้เข้ามาเป็นทนายและมีค่าจ้างทนาย ตามใบเสร็จศาล ประมาณ150000 บาท ดิฉันไม่มีเงินก้อนเลยตกลงกันว่าจะผ่อนให้  เรื่อยๆ เเล้วแต่เค้าจะเรียก 5000 บ้าง 7000 บ้าง 1หมื่นบ้าง เป็นครั้งคราวไป ดิฉันขายขายของได้เท่าไหร่ ก็ให้เค้าหมด เพื่อหวังให้ทุกอย่าง จบ .....แต่มันไม่เป็นแบบนั้น  ศาลชั้นต้นตัดสินยืน ทนายเลยบอกให้ อุธรณ์อีกครั้ง เพราะศาลชั้นต้นอ่านจะไม่ละเอียดพอ  ระหว่างนั้นสามีดิฉันเข้าไปอยู่ในเรือนจำ รอประกันออกมา  อ่อลืมบอกไปค่ะ ตอนเเรกที่เจอทนายคนนี้เพราะเค้าโทรมาบอกว่าเป็นเจ้าของหลักทรัพย์ที่เราไปเช่ากับนายหน้า ตอนนั้นไม่มรทนายเลยให้เค้าช่วย ใจคิดแล้วว่าเป็นโชคดีของเรา",
      "createDate": "05/02/2569",
      "lawyerApprove": false,
      "lawyerModel": {},
      "position": const LatLng(13.7440, 100.5297),
      "status": "0",
      "statusText": "รอทนายรับเรื่อง"
    },
  ];

  dynamic modelPost = {
    "code": "0",
    "name": "ศักดิ์สิทธิ์ พิพากษ์",
    "category": "กฏหมายครอบครัว",
    "story":
        "เมื่อ2ปีที่แล้ว ดิฉันได้จ้างทนายท่านนี้เพื่อทำคดีของสามีเพื่อหาวิธีสู้คดีเพราะเราบริสุทธิ์คือโดนแทนพี่ชายอ่ะคะทนายท่านนี้ได้เข้ามาเป็นทนายและมีค่าจ้างทนาย ตามใบเสร็จศาล ประมาณ150000 บาท ดิฉันไม่มีเงินก้อนเลยตกลงกันว่าจะผ่อนให้  เรื่อยๆ เเล้วแต่เค้าจะเรียก 5000 บ้าง 7000 บ้าง 1หมื่นบ้าง เป็นครั้งคราวไป ดิฉันขายขายของได้เท่าไหร่ ก็ให้เค้าหมด เพื่อหวังให้ทุกอย่าง จบ .....แต่มันไม่เป็นแบบนั้น  ศาลชั้นต้นตัดสินยืน ทนายเลยบอกให้ อุธรณ์อีกครั้ง เพราะศาลชั้นต้นอ่านจะไม่ละเอียดพอ  ระหว่างนั้นสามีดิฉันเข้าไปอยู่ในเรือนจำ รอประกันออกมา  อ่อลืมบอกไปค่ะ ตอนเเรกที่เจอทนายคนนี้เพราะเค้าโทรมาบอกว่าเป็นเจ้าของหลักทรัพย์ที่เราไปเช่ากับนายหน้า ตอนนั้นไม่มรทนายเลยให้เค้าช่วย ใจคิดแล้วว่าเป็นโชคดีของเรา",
    "createDate": "9 ชั่วโมงที่ผ่านมา",
    "lawyerApprove": true,
    "lawyerModel": {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "scroll": 4.8,
      "cost": "ไม่เสียค่าใช้จ่าย",
      "costUnit": "/hr",
      "imageUrl": "assets/images/lawyer-avatar-1.png",
      "experience": "11+ years",
      "skills": [
        "Family lawyer",
        "Estate planning lawyer",
      ]
    },
    "position": const LatLng(0, 0),
    "status": "1",
    "statusText": "กำลังดำเนินการ"
  };

  @override
  void initState() {
    getCurrentLocation();
    super.initState();

    cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    cardAnimation = Tween<double>(
      begin: -200,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: cardController,
        curve: Curves.easeOut,
      ),
    );

    // cardLawyerController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );

    // cardLawyerAnimation = Tween<double>(
    //   begin: -200,
    //   end: 0,
    // ).animate(
    //   CurvedAnimation(
    //     parent: cardLawyerController,
    //     curve: Curves.easeOut,
    //   ),
    // );

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    addAnimationCardLawyer();
  }

  addAnimationCardLawyer() {
    cardLawyerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    cardLawyerAnimation = Tween<double>(
      begin: -400,
      end: 0,
    ).animate(cardLawyerController)
      ..addListener(() {
        // moveCar();
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            setState(
              () {
                isSearching = false;
                lawyerApproveDetail = {
                  "code": "0",
                  "name": "ศักดิ์สิทธิ์ พิพากษ์",
                  "scroll": 4.8,
                  "cost": "ไม่เสียค่าใช้จ่าย",
                  "costUnit": "/hr",
                  "imageUrl": "assets/images/lawyer-avatar-1.png",
                  "experience": "11+ years",
                  "skills": [
                    "Family lawyer",
                    "Estate planning lawyer",
                  ]
                };

                found = true;
              },
            );
          }
        },
      );
  }

  void moveCar() {
    double lat = lerpDouble(carLocation.latitude, userLocation.latitude,
        cardLawyerAnimation.value)!;

    double lng = lerpDouble(carLocation.longitude, userLocation.longitude,
        cardLawyerAnimation.value)!;

    setState(() {
      carLocation = LatLng(lat, lng);
    });
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    final latLng = LatLng(position.latitude, position.longitude);

    setState(() {
      currentLocation = latLng;
    });

    if (_mapReady) {
      mapController.move(latLng, 16);
    }
  }

  void onMarkerTap(Map<String, dynamic> location) {
    setState(() {
      selectedLocation = location;
    });

    mapController.move(
      location["position"],
      16,
    );

    cardController.forward();
  }

  void closeCard() {
    cardController.reverse();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        selectedLocation = null;
      });
    });
  }

  void closeCardLawyer() {
    cardLawyerController.reverse();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        lawyerApproveDetail = null;
        found = false;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    cardLawyerController.dispose();
    cardController.dispose();
    rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBarCustom(
        title: "หมอความออนไลน์",
        backBtn: false,
        isRightWidget: true,
        backAction: () => goBack(),
        rightWidget: selectTab == '0'
            ? GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppAppointment(
                      title: 'โพสปัญหา',
                    ),
                  ),
                ),
                child: Container(
                  width: 40,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 12,
                  //   vertical: 10,
                  // ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    // borderRadius: BorderRadius.circular(22),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                  ),
                  child: SizedBox(
                    width: 20,
                    height: 18,
                    child: Image.asset("assets/icons/app-appointment.png"),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WowMapAnimationPage(),
                    ),
                  ),
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.symmetric(
                  //   horizontal: 12,
                  //   vertical: 10,
                  // ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    // borderRadius: BorderRadius.circular(22),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 15,
                  ),
                ),
              ),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: tabCategory(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: selectTab == '0' ? Container() : _buildFilter2(),
            ),
            selectTab == '0'
                ? Container()
                : const SizedBox(
                    height: 20,
                  ),
            Expanded(
                child: selectTab == '0' ? _buildPost() : _buildLawyerOnline()),
          ],
        ),
      ),
    );
  }

  _buildPost() {
    if (currentLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: currentLocation!,
            initialZoom: 14,
            onMapReady: () {
              _mapReady = true;
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.video_call',
            ),
            MarkerLayer(
              markers: locations.map((location) {
                return Marker(
                  point: location["position"],
                  width: 60,
                  height: 60,
                  child: buildMarker(location),
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: [
                // current location marker
                Marker(
                  point: currentLocation!,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: userLocation,
                  width: 150,
                  height: 150,
                  child: GestureDetector(
                    onTap: () => onMarkerTap(modelPost),
                    child: AnimatedBuilder(
                      animation: rippleController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: RipplePainter(
                            rippleController.value,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Marker(
                //   point: carLocation,
                //   width: 50,
                //   height: 50,
                //   child: const Icon(
                //     Icons.local_taxi,
                //     color: Colors.green,
                //     size: 40,
                //   ),
                // ),
              ],
            ),
          ],
        ),
        buildLocateButton(),
        buildAddPostButton(),
        buildBottomCard(),
        found ? buildLawyerAccept() : Container()
      ],
    );
  }

  _buildFilter2() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: TextEditingController(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 14.00,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              contentPadding: const EdgeInsets.fromLTRB(14.0, 5.0, 14.0, 5.0),
              hintText: "ค้นหาหมอความ...",
              helperStyle:
                  TextStyle(color: const Color(0xFF151A2D).withOpacity(0.7)),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(8, 13, 0, 13),
                child: Image.asset(
                  'assets/icons/search.png',
                  width: 15,
                  height: 15,
                  fit: BoxFit.contain,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                // borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LawyerOnlineFilter(),
              ),
            ),
          },
          child: Container(
              // width: 50,
              // height: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Icon(
                Icons.tune,
                color: const Color(0xFF151A2D).withOpacity(0.7),
                size: 22,
              )),
        ),
      ],
    );
  }

  _buildLawyerOnline() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
      itemCount: lawyerOnlineList.length,
      itemBuilder: (context, index) =>
          _lawyerOnlineItem(lawyerOnlineList[index], onTap: () => {}),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 15,
      ),
    );
  }

  _lawyerOnlineItem(dynamic model, {Function? onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                model['imageUrl'] ?? '',
                height: 80,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['name'] ?? '',
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  for (var item in model['skills'])
                    Text(
                      item ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exp',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFED6B2D),
                          ),
                        ),
                        // const SizedBox(height: 8),
                        Text(
                          model['experience'] ?? '',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${model['scroll'] ?? 0} ⭐',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        // const SizedBox(height: 8),
                        Text(
                          '${model['cost']}${model['cost'] != 'Free' ? model['costUnit'] : ''} ',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3C5065),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LawyerOnlineDetails(
                          code: model['code'],
                        ),
                      ),
                    )
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0262EC),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  tabCategory() {
    return Row(
      children: [
        for (int i = 0; i < tab.length; i++) ...[
          Expanded(
            child: tabItem(
              title: tab[i]['title'],
              active: tab[i]['code'] == selectTab,
              onTap: () => {
                setState(
                  () {
                    selectTab = tab[i]['code'];
                  },
                ),
              },
            ),
          ),
          if (i != tab.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }

  tabItem({required String title, bool active = false, Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFf8fafe) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: active ? const Color(0xFF0262EC) : const Color(0xFFE1E1E1),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: active
                ? const Color(0xFF0262EC)
                : const Color(0xFF000020).withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildMarker(Map<String, dynamic> location) {
    bool isSelected = selectedLocation?["code"] == location["code"];

    return GestureDetector(
      onTap: () => onMarkerTap(location),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          Icons.location_pin,
          color: isSelected ? Colors.green : Colors.red,
          size: isSelected ? 50 : 40,
        ),
      ),
    );
  }

  Widget buildBottomCard() {
    if (selectedLocation == null) return const SizedBox();

    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        return Positioned(
          left: 16,
          right: 16,
          bottom: cardAnimation.value + 120,
          child: child!,
        );
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLocation!["category"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: closeCard,
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text(
                selectedLocation!["story"],
                style: const TextStyle(
                    fontSize: 14, overflow: TextOverflow.ellipsis),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF0262EC)),
                    shadowColor:
                        MaterialStateProperty.all<Color>(Color(0xFF0262EC)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(
                    //       "เลือก ${selectedLocation!["name"]}",
                    //     ),
                    //   ),
                    // );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetails(
                          model: selectedLocation,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "รายละเอียดโพส",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLawyerAccept() {
    if (lawyerApproveDetail == null) return const SizedBox();
    return AnimatedBuilder(
      animation: cardLawyerAnimation,
      builder: (context, child) {
        return Positioned(
          left: 16,
          right: 16,
          bottom: cardLawyerAnimation.value + 120,
          child: child!,
        );
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // BG ซ้าย
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/bg-lawyer-card-left.png',
                        height: constraints.maxHeight,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // BG ขวา
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/bg-lawyer-card-right.png',
                        height: constraints.maxHeight,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // AVATAR
                    Positioned(
                      right: 0,
                      top: 10,
                      bottom: 0,
                      child: Image.asset(
                        'assets/images/avatar-lawyer-card.png',
                        height: constraints.maxHeight,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Positioned(
                      right: 0,
                      top: 0,
                      // bottom: 0,
                      child: IconButton(
                        onPressed: closeCardLawyer,
                        icon: const Icon(Icons.close),
                      ),
                    ),

                    // CONTENT CARD
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  lawyerApproveDetail!['name'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${lawyerApproveDetail!['scroll'] ?? 0} ⭐',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF0262EC),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${lawyerApproveDetail!['cost']}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                                lawyerApproveDetail!['cost'] != "Free"
                                    ? Text(
                                        '${lawyerApproveDetail!['costUnit']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF0262EC)),
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF0262EC)),
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      onPressed: () {
                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //       "เลือก ${selectedLocation!["name"]}",
                                        //     ),
                                        //   ),
                                        // );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LawyerOnlineDetails(
                                              code: lawyerApproveDetail['code'],
                                            ),
                                          ),
                                        ).then((value) => {
                                              // print(value)
                                              if (value)
                                                rippleController.reverse()
                                            });
                                        closeCardLawyer();
                                      },
                                      child: Text(
                                        "ข้อมูลทนาย",
                                        style: GoogleFonts.prompt(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(15),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             lawyerApproveDetail!["category"],
        //             style: const TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           IconButton(
        //             onPressed: closeCard,
        //             icon: const Icon(Icons.close),
        //           )
        //         ],
        //       ),
        //       const SizedBox(height: 8),
        //       Text(
        //         lawyerApproveDetail!["story"],
        //         style: const TextStyle(
        //             fontSize: 14, overflow: TextOverflow.ellipsis),
        //         maxLines: 3,
        //       ),
        //       const SizedBox(height: 16),
        //       SizedBox(
        //         width: double.infinity,
        //         child: ElevatedButton(
        //           style: ButtonStyle(
        //             backgroundColor:
        //                 MaterialStateProperty.all<Color>(Color(0xFF0262EC)),
        //             shadowColor:
        //                 MaterialStateProperty.all<Color>(Color(0xFF0262EC)),
        //             elevation: MaterialStateProperty.all(0),
        //           ),
        //           onPressed: () {
        //             // ScaffoldMessenger.of(context).showSnackBar(
        //             //   SnackBar(
        //             //     content: Text(
        //             //       "เลือก ${selectedLocation!["name"]}",
        //             //     ),
        //             //   ),
        //             // );

        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => PostDetails(
        //                   model: selectedLocation,
        //                 ),
        //               ),
        //             );
        //           },
        //           child: Text(
        //             "รายละเอียดโพส",
        //             style: GoogleFonts.prompt(
        //               fontSize: 16,
        //               fontWeight: FontWeight.w600,
        //               color: Colors.white,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget buildLocateButton() {
    return Positioned(
      right: 16,
      bottom: 200,
      child: FloatingActionButton(
        backgroundColor: Color(0xFFED6B2D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          // side: const BorderSide(color: Color(0xFF0262EC)),
        ),
        onPressed: () {
          if (currentLocation != null && _mapReady) {
            mapController.move(currentLocation!, 14);
          }
        },
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildAddPostButton() {
    return Positioned(
      right: 16,
      bottom: 130,
      child: FloatingActionButton(
        backgroundColor: Color(0xFF0262EC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          // side: const BorderSide(color: Color(0xFF0262EC)),
        ),
        onPressed: () {
          openChatBottomSheet(context);
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  void startSearch() {
    setState(() {
      isSearching = true;
      found = false;
      seconds = 4; // reset ทุกครั้ง
      userLocation = currentLocation!;
    });
    // rippleController.forward();
    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    timer?.cancel(); // กัน timer ซ้ำ

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 1) {
        setState(() {
          seconds--;
        });
      } else {
        t.cancel();
        setState(() {
          seconds = 0;
          found = true; // ให้ card แสดง
          isSearching = false;
        });

        cardLawyerController.forward(); // ค่อยเล่น animation
        // addAnimationCardLawyer();
      }
    });
  }

  void openChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 10,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: SafeArea(
            bottom: false,
            child: AnimatedPadding(
              curve: Curves.linear,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              duration: const Duration(milliseconds: 50),
              child: Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.bottom) -
                    50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "โพสต์ปัญหา",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  // height: 43,
                                  child: dropdownCustom(
                                      label: "ประเภทคดี",
                                      list: postCategoryList,
                                      isRequired: true,
                                      valueSelect: selectedCategory),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: SizedBox(
                                  // height: 43,
                                  child: dropdownCustom(
                                      label: "ประเภทคดีย่อย",
                                      list: postSubCategoryList,
                                      isRequired: true,
                                      valueSelect: selectedSubCategory),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          selectDate(
                              title: 'วันนัดหมายปรึกษา*',
                              controller: dateController),
                          Row(
                            children: [],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              // padding: EdgeInsets.symmetric(vertical: 10),
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  maxLines: null,
                                  minLines: 10,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFFFFFFF),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        0.0, 5.0, 0.0, 5.0),
                                    hintText: "พิมพ์ปัญหาที่นี่...",
                                    hintStyle:
                                        const TextStyle(letterSpacing: 0.5),
                                    helperStyle: TextStyle(
                                      color: const Color(0xFF151A2D)
                                          .withOpacity(0.7),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/chat-camera.png',
                                width: 26,
                                height: 26,
                                color: Color(0xFF0262EC),
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/icons/input-gallery.png',
                                width: 26,
                                height: 26,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/icons/input-emoji.png',
                                width: 26,
                                height: 26,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            goBack();
                          },
                          child: Container(
                            // width: 50,
                            // height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              // borderRadius: BorderRadius.circular(18),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFFDBDBDB),
                              ),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => {
                            if (!isSearching && !found)
                              {
                                setState(() {
                                  modelPost['position'] = currentLocation;
                                  lawyerApproveDetail = {
                                    "code": "0",
                                    "name": "ศักดิ์สิทธิ์ พิพากษ์",
                                    "scroll": 4.8,
                                    "cost": "ไม่เสียค่าใช้จ่าย",
                                    "costUnit": "/hr",
                                    "imageUrl":
                                        "assets/images/lawyer-avatar-1.png",
                                    "experience": "11+ years",
                                    "skills": [
                                      "Family lawyer",
                                      "Estate planning lawyer",
                                    ]
                                  };
                                }),
                                startSearch(),
                                goBack(),
                              }
                          },
                          child: Container(
                            // width: 50,
                            // height: 50,
                            padding: const EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   color: const Color(0xFFFAFAFA),
                            //   // borderRadius: BorderRadius.circular(18),
                            //   shape: BoxShape.circle,
                            //   border: Border.all(
                            //     width: 1,
                            //     color: const Color(0xFFDBDBDB),
                            //   ),
                            // ),
                            child: const Text(
                              "โพสต์",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0262EC),
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  dropdownCustom(
      {required String label,
      bool isRequired = false,
      required List<Map<String, String>> list,
      String? valueSelect}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.prompt(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0262EC),
            ),
            children: [
              TextSpan(
                text: isRequired ? " *" : "",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        StatefulBuilder(builder: (context, setModalState) {
          return DropdownButtonFormField<String>(
            value: valueSelect,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            style: GoogleFonts.prompt(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "กรุณาระบุหัวเรื่องที่จะปรึกษา",
              hintStyle: GoogleFonts.prompt(
                fontSize: 14,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5), // สีเทาอ่อน
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
            ),
            items: list.map((e) {
              return DropdownMenuItem<String>(
                value: e['code'],
                child: Text(e['title']!),
              );
            }).toList(),
            onChanged: (value) {
              setModalState(() {
                // selectedCategory = value;
                valueSelect = value;
              });
            },
          );
        }),
      ],
    );
  }

  selectDate(
      {String title = '',
      TextEditingController? controller,
      bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: GoogleFonts.prompt(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0262EC),
            ),
            children: <TextSpan>[
              TextSpan(
                text: isRequired ? '*' : '',
                style: const TextStyle(
                  color: Color(0xFFDB2E26),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            suffixIcon: const Icon(Icons.calendar_today_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFECEDF0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFECEDF0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFECEDF0),
              ),
            ),
            fillColor: const Color(0xFFFAFAFA),
            filled: true,
          ),
          onTap: () => showCupertinoModalPopup(
            context: context,
            builder: (_) => Container(
              height: 300,
              color: Colors.white,
              child: Column(
                children: [
                  /// ปุ่ม Done ด้านบน
                  Container(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                      child: Text(
                        "เสร็จสิ้น",
                        style: GoogleFonts.prompt(
                          fontSize: 16,
                          // fontWeight: FontWeight.w600,
                          color: const Color(0xFF0262EC),
                        ),
                      ),
                      onPressed: () {
                        // timeCallBack!(DateFormat('HH:mm').format(selectedTime));
                        setState(() {
                          controller!.text =
                              DateFormat('dd/MM/yyyy').format(selectedTime);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  /// Time Picker
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      dateOrder: DatePickerDateOrder.dmy,
                      use24hFormat: true, // เปลี่ยนเป็น false ถ้าอยากได้ AM/PM
                      initialDateTime: selectedTime,
                      onDateTimeChanged: (DateTime newTime) {
                        selectedTime = newTime;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
