import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/lawyer-online-details.dart';
import 'package:video_call/menu.dart';

class LawyerOnlineFilter extends StatefulWidget {
  const LawyerOnlineFilter({super.key});

  @override
  State<LawyerOnlineFilter> createState() => _LawyerOnlineFilterState();
}

class _LawyerOnlineFilterState extends State<LawyerOnlineFilter> {
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

  dynamic filter = {
    "txtSearch": "",
    "category": "0",
    "date": {
      "sunday": false,
      "monday": false,
      "tuesday": false,
      "wednesday": false,
      "thursday": false,
      "friday": false,
      "saturday": false
    }
  };

  String? selectedCategory = "0";

  int? trueCount;

  @override
  void initState() {
    countDayTrue();
    super.initState();
  }

  countDayTrue() {
    setState(() {
      trueCount = (filter['date'] as Map<String, dynamic>)
          .values
          .where((v) => v == true)
          .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "ค้นหาหมอความออนไลน์",
        backBtn: true,
        rightBtn: true,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: TextEditingController(text: filter['txtSearch']),
                    initialValue: filter['txtSearch'],
                    onChanged: (value) => {
                      setState(() {
                        filter['txtSearch'] = value;
                      })
                    },
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
                        borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              // underline: const SizedBox(),
              padding: EdgeInsets.zero,
              isExpanded: true,
              style: GoogleFonts.prompt(
                fontSize: 14,
                // fontWeight: FontWeight.w600,
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
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'วันนัดหมายคดีความ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF006FFD)),
                  alignment: Alignment.center,
                  child: Text(
                    trueCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            chkDay(
                title: 'วันอาทิตย์',
                value: filter['date']['sunday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['sunday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันจันทร์',
                value: filter['date']['monday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['monday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันอังคาร',
                value: filter['date']['tuesday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['tuesday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันพุธ',
                value: filter['date']['wednesday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['wednesday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันพฤหัสบดี',
                value: filter['date']['thursday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['thursday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันศุกร์',
                value: filter['date']['friday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['friday'] = value;
                        countDayTrue();
                      })
                    }),
            chkDay(
                title: 'วันเสาร์',
                value: filter['date']['saturday'],
                callback: (value) => {
                      setState(() {
                        filter['date']['saturday'] = value;
                        countDayTrue();
                      })
                    }),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => {goBack()},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xFF0262EC),
                    borderRadius: BorderRadius.circular(18)),
                child: const Text(
                  "ค้นหา",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Expanded(child: _buildLawyerOnline()),
          ],
        ),
      ),
    );
  }

  chkDay({bool? value, String? title, required Function? callback}) {
    return CheckboxListTile(
      value: value,
      onChanged: (value) => callback!(value),
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading, // checkbox อยู่ซ้าย
      dense: true,
      visualDensity: const VisualDensity(
        vertical: -4, // ⭐ ยิ่งติดลบยิ่งชิด
        horizontal: -4,
      ),
      activeColor: const Color(0xFF0262EC),
      side: const BorderSide(width: 1, color: Color(0xFF0262EC)),
      splashRadius: 5,
      contentPadding: EdgeInsets.zero,
      checkboxScaleFactor: 1,
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
