import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_call/component/appbar.dart';

class ConsultationSchedule extends StatefulWidget {
  ConsultationSchedule({Key? key, this.model});

  dynamic model;

  @override
  State<ConsultationSchedule> createState() => _ConsultationScheduleState();
}

class _ConsultationScheduleState extends State<ConsultationSchedule> {
  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  DateTime selectedTime = DateTime.now();

  final TextEditingController costPerHrController = TextEditingController();

  List<Map<String, String>> postCategoryList = [
    {"code": "0", "title": "ทุกวัน"},
    {"code": "1", "title": "สุดสัปดาห์"},
    {"code": "2", "title": "วันธรรมดา"},
  ];
  String? selectedCategory = "0";

  List<dynamic> statusRangeList = [
    {"code": "0", "title": "วันนี้"},
    {"code": "1", "title": "สัปดาห์นี้"},
    {"code": "2", "title": "เดือนนี้"},
  ];
  String? selectedStatusRange = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "ตารางวันปรึกษา",
        backBtn: true,
        rightBtn: false,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        children: [
          const SizedBox(
            height: 30,
          ),
          _appointmentDetailsCard(),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    setState(() {
                      _startController.text = "";
                      _endController.text = "";
                      costPerHrController.text = "";
                      selectedCategory = '';
                    })

                    // successDialog()
                    // AwesomeDialog(
                    //   context: context,
                    //   dialogType: DialogType.success,
                    //   animType: AnimType.scale,
                    //   customHeader: const Icon(
                    //     Icons.check_circle,
                    //     color: Colors.green,
                    //     size: 110,
                    //   ),
                    //   title: 'สำเร็จ',
                    //   desc: 'บันทึกข้อมูลเรียบร้อยแล้ว',
                    //   btnOkOnPress: () {
                    //     goBack();
                    //   },
                    // ).show()
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFBAD5FF),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 1, color: const Color(0xFFDBDBDB))),
                    child: const Text(
                      "ล้างค่าทั้งหมด",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0262EC),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    // successDialog()
                    // AwesomeDialog(
                    //   context: context,
                    //   dialogType: DialogType.success,
                    //   animType: AnimType.scale,
                    //   customHeader: const Icon(
                    //     Icons.check_circle,
                    //     color: Colors.green,
                    //     size: 110,
                    //   ),
                    //   title: 'สำเร็จ',
                    //   desc: 'บันทึกข้อมูลเรียบร้อยแล้ว',
                    //   btnOkOnPress: () {
                    //     goBack();
                    //   },
                    // ).show()
                    dialogSuccess()
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0262EC),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 1, color: const Color(0xFFDBDBDB))),
                    child: const Text(
                      "ยืนยันการนัดหมาย",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _appointmentDetailsCard() {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.white,
          // borderRadius: BorderRadius.circular(24),
          ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          dropdown(title: 'วันนัดหมายปรึกษา', list: postCategoryList),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: selectTime(
                  title: 'เริ่มจาก',
                  controller: _startController,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: selectTime(
                  title: 'จนถึง',
                  controller: _endController,
                ),
              ),
              // selectTime(title: 'จนถึง')
            ],
          ),
          const SizedBox(height: 20),
          textField(title: 'ราคาต่อชั่วโมง'),
          const SizedBox(height: 20),
          _buildStatusRange(title: 'สถานะ')
        ],
      ),
    );
  }

  dropdown(
      {required List<Map<String, String>>? list,
      Function? onChange,
      String title = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xFF0262EC)),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          // underline: const SizedBox(),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          padding: EdgeInsets.zero,
          isExpanded: true,
          style: GoogleFonts.prompt(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          value: selectedCategory,
          items: list!.map((e) {
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
      ],
    );
  }

  selectTime({String title = '', TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xFF0262EC)),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            suffixIcon: const Icon(Icons.access_time),
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
                              DateFormat('HH:mm').format(selectedTime);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  /// Time Picker
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
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

  textField({Function? onChange, String title = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xFF0262EC)),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: costPerHrController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        ),
      ],
    );
  }

  _selectTime({TextEditingController? controller}) async {
    return showCupertinoModalPopup(
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
                    controller!.text = DateFormat('HH:mm').format(selectedTime);
                  });
                  Navigator.pop(context);
                },
              ),
            ),

            /// Time Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
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
    );
  }

  _buildStatusRange({String? title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(fontSize: 12, color: Color(0xFF0262EC)),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            for (int i = 0; i < statusRangeList.length; i++) ...[
              Expanded(
                child: _statusRangeItem(
                  title: statusRangeList[i]['title'],
                  value: statusRangeList[i]['code'],
                  onChange: () => {
                    setState(
                      () {
                        selectedStatusRange = statusRangeList[i]['code'];
                      },
                    ),
                  },
                ),
              ),
              if (i != statusRangeList.length - 1) const SizedBox(width: 15),
            ],
          ],
        ),
      ],
    );
  }

  _statusRangeItem(
      {Function? onChange, String title = '', String value = '0'}) {
    return GestureDetector(
      onTap: () => onChange!(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: value == selectedStatusRange
                    ? const Color(0xFF0262EC)
                    : const Color(0xFFBAD5FF)),
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: value == selectedStatusRange
                ? const Color(0xFF0262EC)
                : const Color(0xFF555E67),
          ),
          textAlign: TextAlign.center,
        ),
      ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 71,
                    height: 71,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: const Color(0xFF0262EC),
                      ),
                    ),
                    child: const Icon(Icons.check,
                        color: Color(0xFF0262EC),
                        size: 40,
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'ทำการนัดหมายสำเร็จ',
                    style: TextStyle(
                        color: Color(0xFF0262EC),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => {
                      goBack(),
                      goBack(),
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
        });
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
