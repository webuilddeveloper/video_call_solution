import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:video_call/component/appbar.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({Key? key, this.model});

  dynamic model;

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "นัดหมาย",
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
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
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
                      btnOkOnPress: () {
                        goBack();
                      },
                    ).show()
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFED6B2D),
                        borderRadius: BorderRadius.circular(18)),
                    child: const Text(
                      "ไม่อนุมัติ",
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
              const SizedBox(width: 20,),
              Expanded(
                child: GestureDetector(
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
                      btnOkOnPress: () {
                        goBack();
                      },
                    ).show()
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF0262EC),
                        borderRadius: BorderRadius.circular(18)),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            appointmentItem(
                title: 'ชื่อลูกความ', value: widget.model['clientName']),
            SizedBox(height: 10),
            appointmentItem(
                title: 'ประเภทคดี', value: widget.model['caseType']),
            SizedBox(height: 10),
            appointmentItem(
                title: 'ประเภทคดีย่อย', value: widget.model['subCaseType']),
            SizedBox(height: 10),
            appointmentItem(
                title: 'วันที่นัดหมาย',
                value: widget.model['appointmentDate'],
                icon: 'assets/icons/calendar-appointment.png'),
            SizedBox(height: 10),
            appointmentItem(
                title: 'ช่วงเวลา',
                value: widget.model['appointmentTime'],
                icon: 'assets/icons/time-appointment.png'),
            SizedBox(height: 10),
            appointmentItem(title: 'ห้วข้อคดี', value: widget.model['title']),
            SizedBox(height: 10),
            appointmentItem(
                title: 'รายละเอียดเพิ่มเติม', value: widget.model['details']),
            SizedBox(height: 10),
            appointmentItem(
                title: 'สถานะการชำระเงิน',
                value: widget.model['paymentStatus'],
                isStatus: true),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  appointmentItem(
      {String? title,
      String value = '',
      String icon = '',
      bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title!,
            style: const TextStyle(color: Color(0xFF808080), fontSize: 13),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              isStatus
                  ? Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: value == '0'
                              ? Colors.red.shade700
                              : Color(0xFF34C759)),
                    )
                  : icon != ''
                      ? Image.asset(
                          icon,
                          width: 16,
                          height: 16,
                          color: Colors.black,
                        )
                      : Container(),
              SizedBox(
                width: (isStatus || icon != '') ? 8 : 0,
              ),
              Expanded(
                child: Text(
                  isStatus
                      ? (value == '0' ? 'รอชำระเงิน' : 'ชำระเงินสำเร็จ')
                      : value,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                  maxLines: null,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
