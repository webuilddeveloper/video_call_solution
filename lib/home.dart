import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/appointment-details.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/lawyer-online-details.dart';
import 'package:video_call/lawyer-online-list.dart';
import 'package:video_call/shared/api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.userType});

  final String? userType;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> mockBannerList = [];
  int _currentBanner = 1;

  List<dynamic> lawyerOnlineList = [
    {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "scroll": 4.8,
      "cost": "Free",
      "imageUrl": "assets/images/lawyer-avatar-1.png",
      "experience": "11+ years",
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
      "imageUrl": "assets/images/lawyer-avatar-2.png",
      "experience": "19+ years",
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
      "imageUrl": "assets/images/lawyer-avatar-3.png",
      "experience": "10+ years",
      "skills": [
        "Criminal lawyer",
        "Tax lawyer",
      ]
    },
    {
      "code": "3",
      "name": "อาริย์ ศิษย์กฎหมาย",
      "scroll": 3.0,
      "cost": "200/hr",
      "imageUrl": "assets/images/lawyer-avatar-4.png",
      "experience": "12+ years",
      "skills": [
        "Tax lawyer",
      ]
    },
    {
      "code": "4",
      "name": "Sachin K",
      "scroll": 4.9,
      "cost": "1000/hr",
      "imageUrl": "assets/images/lawyer-avatar-5.png",
      "experience": "20+ years",
      "skills": [
        "Criminal lawyer",
        "Bankruptcy lawyer",
      ]
    }
  ];

  List<Map<String, String>> postCategoryList = [
    {"code": "0", "title": "กฏหมายแพ่งและอาญา"},
    {"code": "1", "title": "กฏหมายครอบครัว"},
    {"code": "2", "title": "กฏหมายแรงงาน"},
    {"code": "3", "title": "ที่ดินและอสังหาริมทรัพย์"},
    {"code": "4", "title": "ธุรกิจและการค้า"},
    {"code": "5", "title": "แรงงานต่างด้าว"},
    {"code": "6", "title": "เทคโนโลยี/ออนไลน์"},
    {"code": "7", "title": "นักสืบ/สืบสวน"},
  ];

  String? selectedCategory = "0";

  List<dynamic> appointmentList = [
    {
      "code": "0",
      "clientName": "อนงค์ ดำเนิน",
      "caseType": "คดีมรดกทุกประเภท",
      "subCaseType": "ฟ้องร้องมรดก",
      "appointmentDate": "28/03/2026",
      "appointmentTime": "11.00 - 14.00",
      "title": "ขอฟ้องร้องมรดกพี่น้อง",
      "details":
          "ต้องการฟ้องร้องพี่น้องที่โกงเงินมรดกอย่าตั้งใจเป็นเวลานานไม่แบ่งใครเป็นมรดกของคุณพ่อแต่คุณแม่ยังมีชีวิตอยู่",
      "paymentStatus": "1"
    },
    {
      "code": "1",
      "clientName": "อนงค์ ดำเนิน",
      "caseType": "คดีมรดกทุกประเภท",
      "subCaseType": "ฟ้องร้องมรดก",
      "appointmentDate": "28/03/2026",
      "appointmentTime": "11.00 - 14.00",
      "title": "ขอฟ้องร้องมรดกพี่น้อง",
      "details":
          "ต้องการฟ้องร้องพี่น้องที่โกงเงินมรดกอย่าตั้งใจเป็นเวลานานไม่แบ่งใครเป็นมรดกของคุณพ่อแต่คุณแม่ยังมีชีวิตอยู่",
      "paymentStatus": "1"
    },
  ];

  final storage = FlutterSecureStorage();
  String userType = "";

  @override
  void initState() {
    // canPop = false;
    callRead();
    super.initState();
  }

  callRead() async {
    var user = await storage.read(key: 'userType');
    setState(() {
      userType = widget.userType ?? user.toString();
    });
    await postDio('${mainBannerApi}read', {'skip': 0, 'limit': 10}).then(
      (value) async => {
        setState(
          () {
            mockBannerList = value;
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEEF2F5),
        appBar: appBarHome(
          name: 'ออกแบบ ทดลอง',
          memberType: userType == 'user' ? 'บุคคลทั่วไป' : 'หมอความ',
          imageUrl: 'assets/images/avatar.png',
          rightWidget: Row(
            children: [
              GestureDetector(
                onTap: () => openChatBottomSheet(context),
                child: Container(
                  // width: 50,
                  // height: 50,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                  ),
                  child: Image.asset(
                    "assets/icons/edit-square.png",
                    color: Colors.black,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => {},
                child: Container(
                  // width: 50,
                  // height: 50,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                  ),
                  child: Image.asset(
                    "assets/icons/bell.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Kanit',
                        fontSize: 14.00,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        contentPadding:
                            const EdgeInsets.fromLTRB(14.0, 5.0, 14.0, 5.0),
                        hintText: "Search legal topics...",
                        helperStyle: TextStyle(
                            color: const Color(0xFF151A2D).withOpacity(0.7)),
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
                          borderSide:
                              const BorderSide(color: Color(0xFFDBDBDB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              const BorderSide(color: Color(0xFFDBDBDB)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => {},
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: heightCalculate(150),
              child: _buildBanner(),
            ),
            const SizedBox(
              height: 5,
            ),
            title(
                title: "ประเภทกฏหมาย",
                isRightBtn: true,
                titleRightBtn: "ดูทั้งหมด",
                viewAll: () => {}),
            const SizedBox(
              height: 15,
            ),
            _buildMenuLowCategory(),
            const SizedBox(
              height: 15,
            ),
            userType == 'lawyer' ? Column(
              children: [
                title(
                    title: "นัดหมายที่กำลังจะมาถึง",
                    isRightBtn: true,
                    titleRightBtn: "ดูทั้งหมด",
                    viewAll: () => {}),
                const SizedBox(
                  height: 15,
                ),
                _buildAppointmentList(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ) : Container(),
            title(
              title: "หมอความออนไลน์",
              isRightBtn: true,
              titleRightBtn: "ดูทั้งหมด",
              viewAll: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LawyerOnlineList(),
                  ),
                ),
              },
            ),
            _buildLawyerOnline(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(14),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/avatar.png'),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                'ออกแบบ ทดลอง > ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 43,
                                  child: StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return DropdownButton<String>(
                                        underline: const SizedBox(),
                                        padding: EdgeInsets.zero,
                                        isExpanded: true,
                                        style: GoogleFonts.prompt(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        value: selectedCategory,
                                        items: postCategoryList.map((e) {
                                          return DropdownMenuItem(
                                            value: e['code'],
                                            child: Text(e['title']!),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setModalState(() {
                                            selectedCategory = value;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
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

  _buildBanner() {
    return Stack(
      children: [
        Container(
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 3,
              enlargeCenterPage: false,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              enlargeFactor: 1,
              // enlargeCenterPage: false,
              // viewportFraction: 0.8,
              autoPlay: true,
              // enlargeFactor: 0.4,
              // enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              onPageChanged: (index, reason) {
                setState(() {
                  // reason != null ? _currentBanner = index : _currentBanner = 0;
                  // _currentBanner = (index ?? 0);
                });
              },
            ),
            items: mockBannerList.map(
              (item) {
                int index = mockBannerList.indexOf(item);
                return

                    // Text( item['imageUrl']);
                    GestureDetector(
                        onTap: () {
                          // postTrackClick("แบนเนอร์หน้าแรก");
                          // if (item['action'] == 'out') {
                          //   launchInWebViewWithJavaScript(item['path']);
                          //   // launchURL(path);
                          // } else if (item['action'] == 'in') {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => CarouselForm(
                          //         code: item['code'],
                          //         model: item,
                          //         url: mainBannerApi,
                          //         urlGallery: bannerGalleryApi,
                          //       ),
                          //     ),
                          //   );
                          // } else if (item['action'].toUpperCase() == 'P') {
                          //   postDio('${server}m/Rotation/innserlog', item);
                          //   _callReadPolicyPrivilegeAtoZ(item['code']);
                          // }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(item['imageUrl']),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                const Color.fromARGB(133, 70, 70, 70)
                                    .withOpacity(0.5), // ความจางของสี
                                BlendMode.srcATop, // โหมดการผสมสี
                              ),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item['imageUrl'],
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ));
              },
            ).toList(),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: mockBannerList.map<Widget>((url) {
              int index = mockBannerList.indexOf(url);
              return Container(
                width: _currentBanner == index ? 17.5 : 7.0,
                height: 7.0,
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _buildMenuLowCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _lawTypeItem(
                title: "กฎหมายอาญา",
                icons: "assets/icons/law-type-1.png",
                onTap: () => {}),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: _lawTypeItem(
                title: "กฎหมาย\nครอบครัว",
                icons: "assets/icons/law-type-2.png",
                onTap: () => {}),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: _lawTypeItem(
                title: "กฎหมายบริษัท",
                icons: "assets/icons/law-type-3.png",
                onTap: () => {}),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: _lawTypeItem(
                title: "กฎหมายธุรกิจ",
                icons: "assets/icons/law-type-4.png",
                onTap: () => {}),
          ),
        ],
      ),
    );

    //     Container(
    //   color: Colors.amber,
    //   child: GridView(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 4,
    //       mainAxisSpacing: 12,
    //       crossAxisSpacing: 12,
    //       childAspectRatio: 0.7,
    //     ),
    //     // SliverGridDelegateWithFixedCrossAxisCount(
    //     //   crossAxisCount: 4,
    //     //   // mainAxisSpacing: MediaQuery.of(context).size.width,
    //     //   crossAxisSpacing: 10,
    //     //   childAspectRatio: MediaQuery.of(context).size.width /
    //     //       (MediaQuery.of(context).size.height -
    //     //           (MediaQuery.of(context).size.height * 35 / 80)),
    //     // ),
    //     physics: const ClampingScrollPhysics(),
    //     shrinkWrap: true,
    //     children: [
    //       _lowTypeItem(
    //           title: "กฎหมายอาญา",
    //           icons: "assets/icons/low-type-1.png",
    //           onTap: () => {}),
    //       _lowTypeItem(
    //           title: "กฎหมาย\nครอบครัว",
    //           icons: "assets/icons/low-type-2.png",
    //           onTap: () => {}),
    //       _lowTypeItem(
    //           title: "กฎหมายบริษัท",
    //           icons: "assets/icons/low-type-3.png",
    //           onTap: () => {}),
    //       _lowTypeItem(
    //           title: "กฎหมายธุรกิจ",
    //           icons: "assets/icons/low-type-4.png",
    //           onTap: () => {}),
    //     ],
    //   ),
    // );
  }

  _lawTypeItem(
      {required String title, required String icons, Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 50,
            // width: 50,
            // padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFF0262EC)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                icons,
                fit: BoxFit.contain,
                height: 50,
                // width: 64,
                // width: double.infinity,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  _buildLawyerOnline() {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(15, 12, 15, 20),
        itemCount: lawyerOnlineList.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.topCenter,
          child: _lawyerOnlineItem(
            lawyerOnlineList[index],
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LawyerOnlineDetails(
                    code: lawyerOnlineList[index]['code'],
                  ),
                ),
              ),
            },
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }

  _lawyerOnlineItem(Map model, {Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: 140,
        // height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
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
            const SizedBox(height: 12),
            Text(
              model['name'] ?? '',
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text('${model['scroll'] ?? 0} ⭐',
                style: const TextStyle(fontSize: 12)),
            // const SizedBox(height: 8),
            Text(model['cost'] ?? '', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  heightCalculate(double height) {
    return (((MediaQuery.of(context).size.width *
                    MediaQuery.of(context).size.height) /
                MediaQuery.of(context).size.height) -
            MediaQuery.of(context).size.width) +
        height;
  }

  title(
      {String? title,
      bool isRightBtn = false,
      String? titleRightBtn,
      Function? viewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          isRightBtn
              ? GestureDetector(
                  onTap: () => viewAll!(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFFDBDBDB),
                        )),
                    child: Text(
                      titleRightBtn!,
                      style: const TextStyle(
                          color: Color(0xFF0262EC), fontSize: 12),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _buildAppointmentList() {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
        itemCount: appointmentList.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.topCenter,
          child: _appointmentItem(
            appointmentList[index],
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetails(
                    model: appointmentList[index],
                  ),
                ),
              ),
            },
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 15,
        ),
      ),
    );
  }

  _appointmentItem(Map model, {Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        // height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFBAD5FF),
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.15),
          //     blurRadius: 15,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 56,
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF0262EC)),
              child: Image.asset(
                'assets/icons/calendar-appointment.png',
                height: 34,
                width: 36,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model['title'] ?? '',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/calendar-appointment.png',
                      height: 13,
                      width: 13,
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      model['appointmentDate'] ?? '',
                      style: const TextStyle(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icons/time-appointment.png',
                      height: 13,
                      width: 13,
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      model['appointmentTime'] ?? '',
                      style: const TextStyle(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
