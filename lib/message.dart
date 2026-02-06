import 'package:flutter/material.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/lawyer-online-details.dart';
import 'package:video_call/menu.dart';
import 'package:video_call/message-form.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> lawyerOnlineList = [
    {
      "code": "0",
      "name": "ศักดิ์สิทธิ์ พิพากษ์",
      "imageUrl": "assets/images/lawyer-avatar-1.png",
      "active": true,
      "lastChat": "มีเอกสารที่เกี่ยวข้องมั้ยครับ",
      "lastChatDate": "14:28",
      "unreadCount": 1
    },
    {
      "code": "1",
      "name": "ธนากร นิติศักดิ์",
      "imageUrl": "assets/images/lawyer-avatar-2.png",
      "active": false,
      "lastChat": "ได้รับแล้วครับ",
      "lastChatDate": "yesterday",
      "unreadCount": 3
    },
    {
      "code": "2",
      "name": "อาริย์ ศิษย์กฎหมาย",
      "imageUrl": "assets/images/lawyer-avatar-4.png",
      "active": false,
      "lastChat": "ขอบคุณค่ะ",
      "lastChatDate": "yesterday",
      "unreadCount": 0
    },
    {
      "code": "3",
      "name": "Sachin K",
      "imageUrl": "assets/images/lawyer-avatar-5.png",
      "active": false,
      "lastChat": "Yeah, sure.",
      "lastChatDate": "07/18/2022",
      "unreadCount": 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "กล่องข้อความ",
        backBtn: false,
        rightBtn: false,
        rightAction: () => {},
      ),
      body: Container(
        child: Column(
          children: [
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      itemCount: lawyerOnlineList.length,
      itemBuilder: (context, index) =>
          _lawyerOnlineItem(lawyerOnlineList[index], onTap: () => {}),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
    );
  }

  _lawyerOnlineItem(dynamic model, {Function? onTap}) {
    return GestureDetector(
      onTap: () {
        // MessageFormPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageFormPage(
              model: model,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(6)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      model['imageUrl'] ?? '',
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  model['active']
                      ? Positioned(
                          right: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: const Color(0xFF00CC5E),
                                borderRadius: BorderRadius.circular(100)),
                            alignment: Alignment.center,
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          model['lastChatDate'] ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8593A8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model['lastChat'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8593A8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        model['unreadCount'] > 0
                            ? Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF0262EC),
                                    borderRadius: BorderRadius.circular(100)),
                                alignment: Alignment.center,
                                child: Text(
                                  model['unreadCount'].toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFF6FBFF),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
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
