import 'package:LawyerOnline/component/appbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LawyerOnlineDetails extends StatefulWidget {
  LawyerOnlineDetails({Key? key, this.code});

  String? code;

  @override
  State<LawyerOnlineDetails> createState() => _LawyerOnlineDetailsState();
}

class _LawyerOnlineDetailsState extends State<LawyerOnlineDetails> {
  List<dynamic> lawyerOnlineList = [
    {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "scroll": 4.8,
      "cost": "Free",
      "costUnit": "/hour",
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
      "costUnit": "/hour",
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
      "costUnit": "/hour",
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
      "costUnit": "/hour",
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
      "costUnit": "/hour",
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

  List<dynamic> dateList = [
    {
      "code": "0",
      "text": "Fri",
      "num": "21",
    },
    {
      "code": "1",
      "text": "Sat",
      "num": "22",
    },
    {
      "code": "2",
      "text": "Sun",
      "num": "23",
    },
    {
      "code": "3",
      "text": "Mon",
      "num": "24",
    },
    {
      "code": "4",
      "text": "Tue",
      "num": "25",
    },
  ];

  dynamic model;

  @override
  void initState() {
    // canPop = false;
    callRead();
    super.initState();
  }

  callRead() {
    setState(() {
      model = lawyerOnlineList.firstWhere((x) => x['code'] == widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "หมอความออนไลน์",
        backBtn: true,
        rightBtn: true,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        children: [
          const SizedBox(
            height: 20,
          ),
          _lawyerCard(),
          const SizedBox(
            height: 20,
          ),
          _bookingCard(),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => {
              // successDialog()
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                customHeader: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 110,
                ),
                title: 'สำเร็จ',
                desc: 'บันทึกข้อมูลเรียบร้อยแล้ว',
                btnOkOnPress: () {},
              ).show()
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFF0262EC),
                  borderRadius: BorderRadius.circular(18)),
              child: const Text(
                "จองนัดหมาย",
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
    );
  }

  _lawyerCard() {
    return ClipRRect(
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

                // CONTENT CARD
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              model['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${model['scroll'] ?? 0} ⭐',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0262EC),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${model['cost']}',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 1),
                            ),
                            model['cost'] != "Free"
                                ? Text(
                                    '${model['costUnit']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Container(),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                btmCard(
                                    icon: "assets/icons/phone.png",
                                    action: () {}),
                                const SizedBox(width: 15),
                                btmCard(
                                    icon: "assets/icons/videocall.png",
                                    action: () {}),
                                const SizedBox(width: 15),
                                btmCard(
                                    icon: "assets/icons/chat.png",
                                    action: () {}),
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
    );
  }

  _bookingCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'About Lawyer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var item in model['skills'])
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  width: 1, color: Color(0xFFE1E1E1))),
                          child: Text(
                            item ?? '',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF999999),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                    ],
                  ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       'Select Date',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     Image.asset(
                  //       "assets/icons/calendar.png",
                  //       width: 24,
                  //       height: 24,
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: dateList.map((e) => dateItem(date: e)).toList(),
                  // ),
                  const Divider(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      scoreItem(
                          title: "Cases Won",
                          value: model['casesWon'],
                          icon: "assets/icons/cases-won.png"),
                      scoreItem(
                          title: "Experience",
                          value: model['experience'],
                          icon: "assets/icons/experience.png"),
                      scoreItem(
                          title: "Client Reviews",
                          value: model['clientReviews'],
                          icon: "assets/icons/client-reviews.png"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Social Media Names',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      socialItem(
                          icon: "assets/icons/facebook.png", action: () {}),
                      const SizedBox(width: 15),
                      socialItem(icon: "assets/icons/ig.png", action: () {}),
                      const SizedBox(width: 15),
                      socialItem(icon: "assets/icons/x.png", action: () {}),
                      const SizedBox(width: 15),
                      socialItem(
                          icon: "assets/icons/linkin.png", action: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateItem({dynamic date, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
          width: 53,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.8),
            border: Border.all(
              width: 1,
              color: const Color(0xFFDBDBDB),
            ),
          ),
          child: Column(
            children: [
              Text(
                date['num'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date['text'],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ],
          )),
    );
  }

  Widget scoreItem({
    String? icon,
    required String? title,
    required String? value,
  }) {
    return Container(
        width: 110,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon!,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    value!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title!,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ));
  }

  Widget socialItem({String? icon, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 12,
        //   vertical: 10,
        // ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Image.asset(
          icon!,
          width: 18,
          height: 18,
        ),
      ),
    );
  }

  Widget btmCard({String? icon, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 12,
        //   vertical: 10,
        // ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Image.asset(
          icon!,
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  successDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/success.json',
                width: 120,
              ),
              const Text(
                'สำเร็จ!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'ดำเนินการเรียบร้อยแล้ว',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ปิด'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
