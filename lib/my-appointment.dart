import 'package:flutter/material.dart';
import 'package:LawyerOnline/add-appointment.dart';
import 'package:LawyerOnline/component/appbar.dart';
import 'package:LawyerOnline/lawyer-online-details.dart';
import 'package:LawyerOnline/menu.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
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
      "createDate": "01/02/2026",
      "status": "1",
      "statusText": "ยืนยันการจอง",
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
      "createDate": "05/02/2026",
      "status": "0",
      "statusText": "รอการยืนยัน",
      "skills": [
        "Family lawyer",
        "Estate planning lawyer",
      ]
    }
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
      appBar: appBarCustom(
          title: "นัดหมายของฉัน",
          backBtn: false,
          isRightWidget: true,
          rightWidget: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppAppointment(),
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
          )),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: tabCategory()),
            const SizedBox(
              height: 20,
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      model['createDate'],
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3C5065),
                          height: 1.2),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                              color: model['status'] == '0'
                                  ? const Color(0xFFFFB909)
                                  : model['status'] == '1'
                                      ? const Color(0xFF34C759)
                                      : Colors.red,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          model['statusText'] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
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
                      'รายละเอียด',
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

  void goBack() async {
    Navigator.pop(context, false);
  }
}
