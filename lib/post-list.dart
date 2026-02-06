import 'package:flutter/material.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/lawyer-online-details.dart';
import 'package:video_call/menu.dart';
import 'package:video_call/post-details.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<dynamic> lawyerOnlineList = [
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
      "status": "0",
      "statusText": "รอทนายรับเรื่อง"
    },
  ];

  String selectTab = "0";

  List<dynamic> tab = [
    {"code": "0", "title": "กำลังจะมาถึง"},
    {"code": "1", "title": "ผ่านไปแล้ว"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "โพสต์ของฉัน",
        backBtn: true,
        rightBtn: false,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: Container(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 25),
            //     child: tabCategory()),
            // const SizedBox(
            //   height: 20,
            // ),
            Expanded(child: _buildLawyerOnline()),
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

  _buildLawyerOnline() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      itemCount: lawyerOnlineList.length,
      itemBuilder: (context, index) =>
          _lawyerOnlineItem(lawyerOnlineList[index],
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetails(
                          model: lawyerOnlineList[index],
                        ),
                      ),
                    ),
                  }),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 15,
      ),
    );
  }

  _lawyerOnlineItem(dynamic model, {Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/profile-avatar.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model['category'],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          model['createDate'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 109, 109, 111),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // for (var item in model['lawyerModel']['skills'])
                        //   Text(
                        //     item ?? '',
                        //     style: TextStyle(
                        //       fontSize: 10,
                        //       color: Colors.black.withOpacity(0.2),
                        //     ),
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                    color: model['status'] == '0'
                                        ? const Color.fromARGB(
                                            255, 240, 216, 39)
                                        : model['status'] == '1'
                                            ? const Color.fromARGB(
                                                255, 255, 132, 9)
                                            : model['status'] == '2'
                                                ? const Color(0xFF34C759)
                                                : Colors.red,
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                model['statusText'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                model['story'],
                style: const TextStyle(fontSize: 14),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
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
