import 'package:flutter/material.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/lawyer-online-details.dart';
import 'package:video_call/lawyer-online-filter.dart';
import 'package:video_call/menu.dart';

class LawyerOnlineList extends StatefulWidget {
  const LawyerOnlineList({super.key});

  @override
  State<LawyerOnlineList> createState() => _LawyerOnlineListState();
}

class _LawyerOnlineListState extends State<LawyerOnlineList> {
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
    {"code": "0", "title": "จองล่วงหน้า"},
    {"code": "1", "title": "ปรึกษาทันที"},
  ];

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
              child: Row(
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(14.0, 5.0, 14.0, 5.0),
                        hintText: "ค้นหาหมอความ...",
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: _buildLawyerOnline()),
          ],
        ),
      ),
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

  void goBack() async {
    Navigator.pop(context, false);
  }
}
