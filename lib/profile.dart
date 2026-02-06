import 'package:flutter/material.dart';
import 'package:video_call/component/appbar.dart';
import 'package:video_call/menu.dart';
import 'package:video_call/post-list.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // canPop = false;
    callRead();
    super.initState();
  }

  callRead() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "โปรไฟล์",
        backBtn: false,
        rightBtn: false,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        children: [
          const SizedBox(
            height: 20,
          ),
          profileMenuCard(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget profileMenuCard() {
    return Stack(
      // clipBehavior: Clip.antiAlias,
      alignment: Alignment.topCenter,
      children: [
        // CARD
        Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.fromLTRB(0, 60, 0, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ชื่อ
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ออกแบบ ทดลอง',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0262EC),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.edit,
                    size: 14,
                    color: Color(0xFF0262EC),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Text(
                  'บัญชีของฉัน',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              menuItem(title: 'บัญชีผู้ใช้งาน', onTap: () => {}),
              menuItem(title: 'เปลี่ยนรหัสผ่าน', onTap: () => {}),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Text(
                  'กิจกรรมของคุณ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              menuItem(title: 'การถูกใจ', onTap: () => {}),
              menuItem(title: 'ประวัตินัดหมาย', onTap: () => {}),
              menuItem(
                title: 'โพสต์ของฉัน',
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostList(),
                    ),
                  ),
                },
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Text(
                  'ตั้งค่า',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              menuItem(title: 'ตั้งค่าการแจ้งเตือน', onTap: () => {}),
              menuItem(title: 'เปลี่ยนภาษา /  Language', onTap: () => {}),
              menuItem(title: 'เกี่ยวกับเรา', onTap: () => {}),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFF3581F0),
                          )),
                      child: const Text(
                        "ออกจากระบบ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3581F0),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),

        // AVATAR ลอยครึ่งการ์ด
        Positioned(
          top: 0,
          child: Stack(
            // clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile-avatar.jpg',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),

              // ปุ่มกล้อง
              Positioned(
                bottom: -3,
                right: -3,
                child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0262EC),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.5),
                      child: Image.asset(
                        "assets/icons/camera.png",
                        width: 17,
                      ),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }

  menuItem({required String title, Function? onTap}) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFF0262EC),
                  )
                ],
              ),
            ),
            const Divider(
              color: Color(0xFFD9D9D9),
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
