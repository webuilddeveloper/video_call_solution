import 'dart:async';
import 'dart:io';

import 'package:LawyerOnline/lawyer-online-details.dart';
import 'package:LawyerOnline/map-card.dart';
import 'package:LawyerOnline/post-details.dart';
import 'package:LawyerOnline/shared/api_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:LawyerOnline/component/appbar.dart';
import 'package:LawyerOnline/consultation-schedule.dart';
import 'package:LawyerOnline/login.dart';
import 'package:LawyerOnline/post-list.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class PostForm extends StatefulWidget {
  PostForm({Key? key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> with TickerProviderStateMixin {
  final storage = FlutterSecureStorage();

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

  List<dynamic> paymentList = [
    {"code": "0", "title": "QR PromptPay"},
    {"code": "1", "title": "Mobile Banking"},
    {"code": "2", "title": "บัตรเครดิต/บัตรเดบิต"},
  ];

  List<dynamic> bankList = [
    {"code": "0", "title": "Krungthai NEXT", "icon": "assets/icons/ktb.png"},
    {
      "code": "1",
      "title": "Krungsri Mobile App",
      "icon": "assets/icons/krungsri.png"
    },
    {"code": "2", "title": "K PLUS", "icon": "assets/icons/kplus.png"},
    {"code": "3", "title": "SCB Easy", "icon": "assets/icons/scb.png"},
    {
      "code": "4",
      "title": "Bangkok Bank Mobile Banking",
      "icon": "assets/icons/bangkok.png"
    },
  ];

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

  // dynamic modelPost = {
  //   "code": "0",
  //   "name": "ศักดิ์สิทธิ์ พิพากษ์",
  //   "category": "กฏหมายครอบครัว",
  //   "story":
  //       "เมื่อ2ปีที่แล้ว ดิฉันได้จ้างทนายท่านนี้เพื่อทำคดีของสามีเพื่อหาวิธีสู้คดีเพราะเราบริสุทธิ์คือโดนแทนพี่ชายอ่ะคะทนายท่านนี้ได้เข้ามาเป็นทนายและมีค่าจ้างทนาย ตามใบเสร็จศาล ประมาณ150000 บาท ดิฉันไม่มีเงินก้อนเลยตกลงกันว่าจะผ่อนให้  เรื่อยๆ เเล้วแต่เค้าจะเรียก 5000 บ้าง 7000 บ้าง 1หมื่นบ้าง เป็นครั้งคราวไป ดิฉันขายขายของได้เท่าไหร่ ก็ให้เค้าหมด เพื่อหวังให้ทุกอย่าง จบ .....แต่มันไม่เป็นแบบนั้น  ศาลชั้นต้นตัดสินยืน ทนายเลยบอกให้ อุธรณ์อีกครั้ง เพราะศาลชั้นต้นอ่านจะไม่ละเอียดพอ  ระหว่างนั้นสามีดิฉันเข้าไปอยู่ในเรือนจำ รอประกันออกมา  อ่อลืมบอกไปค่ะ ตอนเเรกที่เจอทนายคนนี้เพราะเค้าโทรมาบอกว่าเป็นเจ้าของหลักทรัพย์ที่เราไปเช่ากับนายหน้า ตอนนั้นไม่มรทนายเลยให้เค้าช่วย ใจคิดแล้วว่าเป็นโชคดีของเรา",
  //   "createDate": "9 ชั่วโมงที่ผ่านมา",
  //   "lawyerApprove": true,
  //   "lawyerModel": {
  //     "code": "0",
  //     "name": "ศักดิ์สิทธิ์ พิพากษ์",
  //     "scroll": 4.8,
  //     "cost": "ไม่เสียค่าใช้จ่าย",
  //     "costUnit": "/hr",
  //     "imageUrl": "assets/images/lawyer-avatar-1.png",
  //     "experience": "11+ years",
  //     "skills": [
  //       "Family lawyer",
  //       "Estate planning lawyer",
  //     ]
  //   },
  //   "position": null,
  //   "status": "1",
  //   "statusText": "กำลังดำเนินการ"
  // };

  dynamic modelPost = {};

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

  String? selectedCategory = "0";
  String? selectedSubCategory = "0";

  String? selectedProvince = "0";

  DateTime selectedTime = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController intentController = TextEditingController();

  List<dynamic> provinceList = [];

  List<dynamic> depositList = [
    {"code": "1", "title": "< 1,000"},
    {"code": "2", "title": "< 10,000"},
    {"code": "3", "title": "< 100,000"}
  ];

  int page = 1;

  String? selectedPayment = "0";
  String? selectedBank = "";

  LatLng? currentLocation;
  final MapController mapController = MapController();
  bool _mapReady = false;

  LatLng userLocation = const LatLng(13.736717, 100.523186);

  Map<String, dynamic>? selectedLocation;
  bool found = false;

  late AnimationController cardController;
  late Animation<double> cardAnimation;
  late AnimationController rippleController;
  late AnimationController cardLawyerController;
  late Animation<double> cardLawyerAnimation;

  bool isSearching = false;
  Timer? timer;
  int seconds = 2;

  dynamic selectedFile;
  dynamic selectedImage;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // canPop = false;
    final initialDate = modelPost['dateCase'] ??
        DateFormat('dd/MM/yyyy').format(DateTime.now());

    dateController = TextEditingController(text: initialDate);
    callRead();
    getCurrentLocation();
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

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    cardLawyerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    cardLawyerAnimation = Tween<double>(
      begin: -200,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: cardLawyerController,
        curve: Curves.easeOut,
      ),
    );

    addAnimationCardLawyer();

    super.initState();
  }

  @override
  void dispose() {
    cardController.dispose();
    rippleController.dispose();
    cardLawyerController.dispose();
    super.dispose();
  }

  callRead() {
    _callReadProvince();
    setState(() {});
  }

  Future<void> _callReadProvince() async {
    final param = await postDio("${server}route/province/read", {});

    setState(() {
      provinceList = [
        {"code": "0", "title": "เลือกจังหวัด"},
        ...param
      ];
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        // selectedFile = result.files.single;
        // modelPost['files'].add(selectedFile);
        modelPost['files'] ??= [];
        modelPost['files'].addAll(result.files);
      });

      print("ชื่อไฟล์: ${selectedFile.name}");
      print("ขนาดไฟล์: ${selectedFile.size}");
      print("path: ${selectedFile.path}");
    }
  }

  Future<void> pickImage() async {
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        modelPost['images'] ??= [];
        modelPost['images'].addAll(images);
      });
    }

    print("ชื่อไฟล์: ${modelPost['images']}");

    // if (image != null) {
    //   setState(() {
    //     selectedImage = image; // เก็บ XFile
    //     modelPost['images'].add(selectedImage);
    //   });

    //   print("ชื่อไฟล์: ${selectedImage.name}");
    //   print("path: ${selectedImage.path}");
    // }
  }

  void removeImage(int index) {
    setState(() {
      modelPost['images'].removeAt(index);
    });
  }

  void removeFile(int index) {
    setState(() {
      modelPost['files'].removeAt(index);
    });
  }

  String getFileType(String? ext) {
    if (ext == null) return 'other';

    ext = ext.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) return 'image';
    if (['pdf'].contains(ext)) return 'pdf';
    if (['doc', 'docx'].contains(ext)) return 'word';
    if (['xls', 'xlsx'].contains(ext)) return 'excel';
    if (['mp4', 'mov', 'avi'].contains(ext)) return 'video';
    return 'other';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "เปิดเคสให้ทนาย",
        backBtn: true,
        rightBtn: false,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: Stack(
        children: [
          profileMenuCard(),
          Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        page > 1 ? page-- : null;
                      })
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: page > 1
                            ? Color(0xFFBAD5FF)
                            : Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Text(
                        'ย้อนกลับ',
                        style: TextStyle(
                          fontSize: 18,
                          color: page > 1 ? Color(0xFF0262EC) : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        // page < 2 ? page++ : null;
                        print(page);
                        if (page == 3) {
                          dialogSuccess();
                        } else {
                          page++;
                        }
                      })
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0262EC),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: const Text(
                        'ถัดไป',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // child: Image.asset(
              //   "assets/icons/search-lawyer-btn.png",
              //   width: 100,
              //   height: 100,
              // ),
              // select-lawyer-btn
            ),
          ),
        ],
      ),
    );
  }

  Widget profileMenuCard() {
    if (page == 4) {
      return page4(); // ไม่ต้องใส่ ListView
    }

    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: [
        page == 1
            ? page1()
            : page == 2
                ? page2()
                : page3()
      ],
    );
  }

  page1() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                // height: 43,
                child: dropdownCustom(
                  label: "ประเภทคดี",
                  list: postCategoryList,
                  isRequired: true,
                  valueSelect: modelPost['caseType'] ?? '0',
                  onChanged: (value) {
                    setState(() {
                      modelPost['caseType'] = value;
                      modelPost['caseTypeTitle'] = postCategoryList
                          .firstWhere((x) => x['code'] == value)['title'];
                    });
                  },
                ),
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
                  valueSelect: modelPost['subCaseType'] ?? '0',
                  onChanged: (value) {
                    setState(() {
                      modelPost['subCaseType'] = value;
                      modelPost['subCaseTypeTitle'] = postSubCategoryList
                          .firstWhere((x) => x['code'] == value)['title'];
                      // selectedSubCategory = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: selectDate(
                  title: 'วันนัดหมายปรึกษา*', controller: dateController),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: SizedBox(
                // height: 43,
                child: dropdownCustom(
                  label: "จังหวัดที่เลือก",
                  list: provinceList,
                  isRequired: true,
                  valueSelect: modelPost['provinceCase'] ?? '0',
                  onChanged: (value) {
                    setState(() {
                      modelPost['provinceCase'] = value;
                      modelPost['provinceCaseTitle'] = provinceList
                          .firstWhere((x) => x['code'] == value)['title'];
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                // height: 43,
                child: dropdownCustom(
                  label: "จำนวนเงินที่ต้องการวางมัดจำทนาย",
                  list: depositList,
                  isRequired: true,
                  valueSelect: modelPost['deposit'] ?? '0',
                  onChanged: (value) {
                    setState(() {
                      modelPost['deposit'] = value;
                      modelPost['depositTitle'] = depositList
                          .firstWhere((x) => x['code'] == value)['title'];
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          maxLines: null,
          minLines: 10,
          controller: postController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            contentPadding: const EdgeInsets.all(15),
            hintText: "ข้อเท็จจริง",
            hintStyle: const TextStyle(letterSpacing: 0.5),
            helperStyle: TextStyle(
              color: const Color(0xFF151A2D).withOpacity(0.7),
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
          onChanged: (value) => {
            setState(() {
              modelPost['postDetails'] = value;
              postController.text = value;
            })
          },
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          maxLines: null,
          minLines: 10,
          controller: intentController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            contentPadding: const EdgeInsets.all(15),
            hintText: "เจตจำนง",
            hintStyle: const TextStyle(letterSpacing: 0.5),
            helperStyle: TextStyle(
              color: const Color(0xFF151A2D).withOpacity(0.7),
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
          onChanged: (value) => {
            setState(() {
              modelPost['intentDetails'] = value;
              intentController.text = value;
            })
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 221, 212),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "เอกสารเพิ่มเติม",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => pickFile(),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color(0xFFED6B2D),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFFED6B2D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if ((modelPost['files'] ?? []).length > 0)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: modelPost['files'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 ช่อง
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final file = modelPost['files'][index];
                            final type = getFileType(file.extension);
                            // final image = modelPost['files'][index];

                            Widget content;
                            Color bgColor;

                            switch (type) {
                              case 'image':
                                content = Image.file(
                                  File(file.path!),
                                  fit: BoxFit.cover,
                                );
                                bgColor = Colors.grey.shade200;
                                break;

                              case 'pdf':
                                content = Icon(Icons.picture_as_pdf,
                                    size: 50, color: Colors.red);
                                bgColor = Colors.red.shade50;
                                break;

                              case 'word':
                                content = Icon(Icons.description,
                                    size: 50, color: Colors.blue);
                                bgColor = Colors.blue.shade50;
                                break;

                              case 'excel':
                                content = Icon(Icons.table_chart,
                                    size: 50, color: Colors.green);
                                bgColor = Colors.green.shade50;
                                break;

                              case 'video':
                                content = Icon(Icons.videocam,
                                    size: 50, color: Colors.purple);
                                bgColor = Colors.purple.shade50;
                                break;

                              default:
                                content = Icon(Icons.insert_drive_file,
                                    size: 50, color: Colors.grey);
                                bgColor = Colors.grey.shade100;
                            }
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(child: Center(child: content)),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          file.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ปุ่มลบ
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      removeFile(index);
                                      // setState(() {
                                      //   modelPost['files'].removeAt(index);
                                      // });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close,
                                          size: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 221, 239),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "รูปภาพเพิ่มเติม",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => pickImage(),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color(0xFF0262EC),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF0262EC),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  if ((modelPost['images'] ?? []).length > 0)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: modelPost['images'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 ช่อง
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final image = modelPost['images'][index];

                            return Stack(
                              children: [
                                /// รูป
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(image.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),

                                /// ปุ่มลบ
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () => removeImage(index),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  // Image.file(
                  //   File(selectedImage.path),
                  //   height: 200,
                  // ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  page2() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "สรุปเคส",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 15,
              ),
              textDetails(
                  title: 'ประเภทคดี', value: modelPost['caseTypeTitle'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              textDetails(
                  title: 'ประเภทคดีย่อย',
                  value: modelPost['subCaseTypeTitle'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              textDetails(
                  title: 'จังหวัด',
                  value: modelPost['provinceCaseTitle'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              textDetails(
                  title: 'วันที่นัดหมาย', value: modelPost['dateCase'] ?? ''),
              const SizedBox(
                height: 10,
              ),
              textDetails(
                  title: 'ค่าใช้จ่าย', value: modelPost['dateCase'] ?? ''),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "รายละเอียดข้อเท็จจริง",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              textDetails(title: '', value: modelPost['postDetails']),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "รายละเอียดเจตจำนง",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              textDetails(title: '', value: modelPost['intentDetails']),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 221, 212),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เอกสารเพิ่มเติม",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  if ((modelPost['files'] ?? []).length > 0)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: modelPost['files'].length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 ช่อง
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final file = modelPost['files'][index];
                            final type = getFileType(file.extension);
                            // final image = modelPost['files'][index];

                            Widget content;
                            Color bgColor;

                            switch (type) {
                              case 'image':
                                content = Image.file(
                                  File(file.path!),
                                  fit: BoxFit.cover,
                                );
                                bgColor = Colors.grey.shade200;
                                break;

                              case 'pdf':
                                content = Icon(Icons.picture_as_pdf,
                                    size: 50, color: Colors.red);
                                bgColor = Colors.red.shade50;
                                break;

                              case 'word':
                                content = Icon(Icons.description,
                                    size: 50, color: Colors.blue);
                                bgColor = Colors.blue.shade50;
                                break;

                              case 'excel':
                                content = Icon(Icons.table_chart,
                                    size: 50, color: Colors.green);
                                bgColor = Colors.green.shade50;
                                break;

                              case 'video':
                                content = Icon(Icons.videocam,
                                    size: 50, color: Colors.purple);
                                bgColor = Colors.purple.shade50;
                                break;

                              default:
                                content = Icon(Icons.insert_drive_file,
                                    size: 50, color: Colors.grey);
                                bgColor = Colors.grey.shade100;
                            }
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(child: Center(child: content)),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          file.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 221, 239),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "รูปภาพเพิ่มเติม",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  if ((modelPost['images'] ?? []).length > 0)
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: modelPost['images'].length,
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 ช่อง
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final image = modelPost['images'][index];

                            return Stack(
                              children: [
                                /// รูป
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(image.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  // Image.file(
                  //   File(selectedImage.path),
                  //   height: 200,
                  // ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }

  page3() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "เลือกวิธีการชำระเงิน",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 15,
              ),
              radioCard(
                'QR PromptPay',
                '0',
                [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/icons/qr-promptpay.png',
                      width: 27,
                      height: 27,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              radioCard(
                'Mobile Banking',
                '1',
                [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/icons/mobile-banking.png',
                      width: 23,
                      height: 23,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (selectedPayment == '1')
                Column(
                  children: [
                    _buildBankList(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              radioCard(
                'บัตรเครดิต/บัตรเดบิต',
                '2',
                [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/icons/visa.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      'assets/icons/mastercard.png',
                      // width: 25,
                      height: 15,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  dialogSuccess() {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Color.fromARGB(255, 2, 71, 168).withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // backgroundColor: Color(0xFF0262EC).withOpacity(0.5),
          // shadowColor: Colors.black.withOpacity(0.08),
          elevation: 8,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'สแกน QR Code เพื่อจ่ายเงิน',
                  style: TextStyle(
                      color: Color(0xFF0262EC),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20),
                Container(
                    width: 150,
                    height: 150,
                    child: Image.asset(
                      "assets/images/qrcode-mock.jpg",
                      width: 60,
                      height: 60,
                    )),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => {
                    goBack(),
                    startSearch(),
                    setState(() {
                      page++;
                    })
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 60),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0262EC),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 1, color: const Color(0xFFDBDBDB))),
                    child: const Text(
                      "ตกลง",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  page4() {
    if (currentLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 0),
      child: Stack(
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
                userAgentPackageName: 'td.webuild.lawyer',
              ),
              MarkerLayer(
                markers: locations.where((location) {
                  final pos = location["position"];
                  return pos is LatLng &&
                      pos.latitude.isFinite &&
                      pos.longitude.isFinite;
                }).map((location) {
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
                      onTap: () {
                        // if (currentLocation != null) {
                        //   onMarkerTap(
                        //       {...modelPost, "position": currentLocation});
                        // }
                      },
                      child: AnimatedBuilder(
                        animation: rippleController!,
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
          buildBottomCard(),
          found ? buildLawyerAccept() : Container()
        ],
      ),
    );
  }

  _buildBankList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      shrinkWrap: true,
      itemCount: bankList.length,
      itemBuilder: (context, index) => bankSelect(bankList[index]),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 15,
      ),
    );
  }

  dropdownCustom({
    required String label,
    bool isRequired = false,
    required List<dynamic> list,
    required String? valueSelect,
    required Function(String?) onChanged,
  }) {
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
        DropdownButtonFormField<String>(
          value: list.any((e) => e['code'] == valueSelect)
              ? valueSelect
              : null, // 🔥 ป้องกัน crash

          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),

          items: list.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              value: e['code'],
              child: Text(e['title']),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ],
    );
  }

  void startSearch() {
    setState(() {
      isSearching = true;
      found = false;
      seconds = 2; // reset ทุกครั้ง
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
        TextFormField(
          controller: controller,
          // initialValue: modelPost['dateCase'] ??
          //     DateFormat('dd/MM/yyyy').format(DateTime.now()),
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
                        final formatted =
                            DateFormat('dd/MM/yyyy').format(selectedTime);

                        setState(() {
                          modelPost['dateCase'] = formatted;
                          controller!.text = formatted;
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

  textDetails({String? title, String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title ?? '') != ''
            ? Text(
                title!,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              )
            : Container(),
        Text(
          value!,
          style: TextStyle(color: Color(0xFF808080)),
        ),
      ],
    );
  }

  Widget radioCard(String title, String value, List<Widget> icon) {
    bool isSelected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          value == selectedPayment ? null : selectedBank = '';
          selectedPayment = value;
        });
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFEAF1FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          // border: Border.all(
          //   color: isSelected ? Color(0xFF0262EC) : Colors.grey.shade300,
          //   width: 2,
          // ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Color(0xFF0262EC),
            ),
            SizedBox(width: 10),
            ...icon,
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bankSelect(dynamic value) {
    bool isSelected = selectedBank == value['code'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = '1';
          selectedBank = value['code'];
        });
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFEAF1FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check : null,
              color: Color(0xFF0262EC),
            ),
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                value['icon'],
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Text(
              value['title'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
              maxLines: 2,
            )
          ],
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
    if (selectedLocation == null || cardAnimation == null)
      return const SizedBox();

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
      ),
    );
  }

  void onMarkerTap(Map<String, dynamic> location) {
    final pos = location["position"];

    if (pos is! LatLng) return;
    if (!pos.latitude.isFinite || !pos.longitude.isFinite) return;

    setState(() {
      selectedLocation = location;
    });

    if (_mapReady) {
      mapController.move(pos, 16);
    }

    cardController.forward();
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

  void closeCard() {
    cardController!.reverse();
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

    if (_mapReady && latLng.latitude.isFinite) {
      mapController.move(latLng, 16);
    }
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
                // isSearching = false;
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

  void goBack() async {
    Navigator.pop(context, false);
  }
}

class RipplePainter extends CustomPainter {
  final double value;

  RipplePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue.withOpacity(1 - value)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      size.center(Offset.zero),
      value * 60,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
