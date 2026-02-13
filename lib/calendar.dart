import 'dart:collection';

import 'package:LawyerOnline/appointment-details.dart';
import 'package:LawyerOnline/component/appbar.dart';
import 'package:LawyerOnline/shared/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  ValueNotifier<List<dynamic>>? _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  LinkedHashMap<DateTime, List<dynamic>>? model;
  var markData = [];
  Map<DateTime, List<dynamic>>? itemEvents;

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    // model = LinkedHashMap<DateTime, List<dynamic>>(
    //   equals: isSameDay,
    //   hashCode: getHashCode,
    // )..addAll(
    //     Map.fromIterable(
    //       [0],
    //       key: (item) => DateTime.now(),
    //       value: (item) => [],
    //     ),
    //   );

    // itemEvents = {
    //   DateTime(2026, 2, 10): ['ประชุมทีม', 'ส่งงานลูกค้า'],
    //   DateTime(2026, 2, 11): ['พบลูกความ'],
    //   DateTime(2026, 2, 15): ['Online Consultation', 'Zoom Call 14:00'],
    // };

    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController!.forward();
    getMarkerEvent();
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
    super.dispose();
  }

  getMarkerEvent() async {
    var objectData = [];
    // var value = await storage.read(key: 'dataUserLoginSOLAR');
    // var data = json.decode(value);
    // final result = await postDio(server + "m/EventCalendar/mark/read2", {
    //   "year": DateTime.now().year,
    //   "organization": [],
    // });
    // if (result != null) {
    //   objectData = result;

    //   for (int i = 0; i < objectData.length; i++) {
    //     if (objectData[i]['items'].length > 0) {
    //       markData.add(objectData[i]);
    //     }
    //   }

    // itemEvents = Map.fromIterable(
    //   markData,
    //   key: (item) => DateTime.parse(item['date']),
    //   value: (item) => item['items'],
    // );

    itemEvents = {
      DateTime(2026, 2, 10): [
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
          "caseType": "คดีครอบครัวประเภท",
          "subCaseType": "ฟ้องร้องการหย่าร้าง",
          "appointmentDate": "28/03/2026",
          "appointmentTime": "11.00 - 14.00",
          "title": "ขอฟ้องร้องหย่าร้าง",
          "details": "ต้องการฟ้องร้องหย่าร้างกับสามีคนปัจจุบัน",
          "paymentStatus": "1"
        },
      ],
      DateTime(2026, 2, 11): [
        {
          "code": "0",
          "clientName": "อนงค์ ดำเนิน",
          "caseType": "คดีมรดกทุกประเภท",
          "subCaseType": "ฟ้องร้องมรดก",
          "appointmentDate": "28/03/2026",
          "appointmentTime": "11.00 - 14.00",
          "title": "ขอฟ้องร้องมรดกพี่น้อง ครั้งที่ 2",
          "details":
              "ต้องการฟ้องร้องพี่น้องที่โกงเงินมรดกอย่าตั้งใจเป็นเวลานานไม่แบ่งใครเป็นมรดกของคุณพ่อแต่คุณแม่ยังมีชีวิตอยู่",
          "paymentStatus": "1"
        },
      ],
      DateTime(2026, 2, 15): [
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
      ],
    };

    var mainEvent = LinkedHashMap<DateTime, List<dynamic>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(itemEvents!);

    setState(() {
      model = mainEvent;
    });
    // }
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    // Implementation example
    // print('kEvents ---> $kEvents');

    // return kEvents[day] ?? [];
    // return model![day] ?? [];
    return itemEvents?[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents!.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarCustom(
        title: 'นัดหมาย',
        backBtn: false,
        backAction: () => goBack(),
        isRightWidget: true,
        rightWidget: GestureDetector(
          onTap: () => {},
          child: SizedBox(
            width: 40,
            height: 40,
            child: Image.asset("assets/icons/mail.png"),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(color: Colors.blue),
              ),
              Expanded(
                flex: 6,
                child: Container(color: Color(0xFFEEF2F5)),
              ),
            ],
          ),
          screen(),
        ],
      ),
    );
  }

  screen() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(29),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(
                  0,
                  10,
                ),
              ),
            ],
          ),
          child: TableCalendar<dynamic>(
            locale: 'th_TH',
            firstDay: DateTime.utc(DateTime.now().year - 1, 01, 01),
            lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            availableGestures: AvailableGestures.all,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarStyle: CalendarStyle(
              defaultDecoration: BoxDecoration(
                color: Colors.blue.shade50, // สีพื้นหลัง
                borderRadius: BorderRadius.circular(12),
              ),
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle().copyWith(
                color: Colors.black,
                // fontFamily: 'Sarabun',
                fontWeight: FontWeight.normal,
              ),
              holidayTextStyle: TextStyle().copyWith(
                color: Color(0xFFC5DAFC),
                // fontFamily: 'Sarabun',
                fontWeight: FontWeight.normal,
              ),
            ),
            onDaySelected: _onDaySelected,
            // onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },

            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, day) {
                final thaiMonth = DateFormat.MMMM('th_TH').format(day);
                final buddhistYear = day.year + 543;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      // --- Header เดิม ----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month - 1, 1);
                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 12,
                              color: Color(0xFF0262EC),
                            ),
                          ),
                          // $buddhistYear
                          Text(
                            '$thaiMonth',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 1);
                              });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xFF0262EC),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // --- ⭐ เส้นคั่นระหว่าง Header กับ Day Row ---
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: Color(0xFFD9D9D9),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
              selectedBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0)
                      .animate(_animationController!),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF0262EC),
                    ),
                    width: 35,
                    height: 35,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(
                          fontSize: 16.0,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                );
              },
              defaultBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0)
                      .animate(_animationController!),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    width: 35,
                    height: 35,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(
                        fontSize: 16.0,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.normal,
                        // color: Colors.white
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0)
                      .animate(_animationController!),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Color(0xFF0262EC),
                      ),
                      // color: Color(0xFF2D9CED),
                    ),
                    width: 35,
                    height: 35,
                    child: Text(
                      '${date.day}',
                      style: TextStyle().copyWith(
                        fontSize: 16.0,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.normal,
                        // color: Colors.white
                      ),
                    ),
                  ),
                );
              },
              markerBuilder: (context, day, events) =>
                  events.length > 0 ? _buildEventsMarker(events) : Container(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedEvents!,
              builder: (context, value, _) {
                final thaiMonth = DateFormat.MMMM('th_TH').format(_focusedDay);
                final buddhistYear = _focusedDay.year + 543;
                // return Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // Text(
                //         //   '${_focusedDay.day} $thaiMonth $buddhistYear',
                //         //   style: TextStyle(
                //         //     fontSize: 14,
                //         //   ),
                //         // ),
                //         // Text(
                //         //   '${value.length} กิจกรรม',
                //         //   style: TextStyle(
                //         //     fontSize: 14,
                //         //   ),
                //         // ),
                //         Text(value[index]),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Expanded(
                //       child: value.length > 0
                //           ? ListView.builder(
                //               itemCount: value.length,
                //               itemBuilder: (context, index) {
                //                 return eventCard(value[index]);
                //               },
                //             )
                //           : Padding(
                //               padding: const EdgeInsets.only(top: 50.0),
                //               child: Text(
                //                 'ไม่พบกิจกรรม',
                //                 style: TextStyle(
                //                     fontSize: 20, color: Colors.black),
                //               ),
                //             ),
                //     ),
                //   ],
                // );
                return ListView.separated(
                  padding: EdgeInsets.only(top: 20),
                  shrinkWrap: true,
                  itemCount: value.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentDetails(
                              model: value[index],
                            ),
                          ),
                        ),
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30,
                        // height: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF0262EC),
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
                                  color: const Color(0xFFB0D0F9)),
                              child: Image.asset(
                                'assets/icons/calendar-appointment.png',
                                height: 34,
                                width: 36,
                                fit: BoxFit.contain,
                                color: Color(0xFF0262EC),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value[index]['title'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/calendar-appointment.png',
                                      height: 13,
                                      width: 13,
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      value[index]['appointmentDate'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/time-appointment.png',
                                      height: 13,
                                      width: 13,
                                      fit: BoxFit.contain,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      value[index]['appointmentTime'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
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
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsMarker(List events) {
    if (events.length == 0) ;
    return Positioned(
      bottom: -4,
      right: 0,
      left: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF0262EC),
          // events.length > 1
          //     ? Color(0xFF2D9CED)
          //     : Color(0xFFa7141c).withOpacity(0.8),
        ),
        width: 7.0,
        height: 7.0,
      ),
    );
  }

  eventCard(event) {
    return InkWell(
      onTap: () {},
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12),
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFfF2FAFF),
          borderRadius: BorderRadius.circular(12.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 0,
          //     blurRadius: 3,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                '${event['imageUrl']}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event['title']}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Sarabun',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    event['dateStart'] != '' && event['dateEnd'] != ''
                        ? dateStringToDate(event['dateStart']) +
                            " - " +
                            dateStringToDate(event['dateEnd'])
                        : '',
                    style: TextStyle(fontFamily: 'Sarabun', fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
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
