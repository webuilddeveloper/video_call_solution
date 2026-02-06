import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_call/component/check_avatar.dart';
import 'package:video_call/home.dart';
import 'package:video_call/lawyer-online-list.dart';
import 'package:video_call/message.dart';
import 'package:video_call/my-appointment.dart';
import 'package:video_call/profile.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, this.pageIndex, this.modelprofile})
      : super(key: key);

  final int? pageIndex;
  final modelprofile;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String imageUrl = '';
  List<Widget> pages = <Widget>[];
  int _currentPage = 0;
  DateTime? currentBackPressTime;

  final TextEditingController chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _loadUserProfile();
    pages = <Widget>[
      HomePage(),
      MessagePage(),
      LawyerOnlineList(),
      MyAppointment(),
      ProfilePage(),
    ];
    setState(() {
      _currentPage = widget.pageIndex ?? 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      drawerScrimColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
          onWillPop: confirmExit,
          child: IndexedStack(index: _currentPage, children: pages),
        ),
      ),
      bottomNavigationBar: Container(
        // decoration: const BoxDecoration(

        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(29), topRight: Radius.circular(29)),
        //   // boxShadow: [
        //   //   BoxShadow(
        //   //     color: Color(0xFF000000).withOpacity(0.15),
        //   //     blurRadius: 15,
        //   //     offset: Offset(0, -4),
        //   //   ),
        //   // ],
        // ),
        padding: const EdgeInsets.all(20), // ระยะลอยจากขอบ
        child: Container(
          // padding: const EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xFF010101),
            borderRadius: BorderRadius.circular(67),
          ),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _bottomItem("assets/icons/home.png", 0, title: 'หนัาหลัก'),
              ),
              Expanded(
                child: _bottomItem("assets/icons/message.png", 1,
                    title: 'ข้อความ'),
              ),
              Expanded(
                child: _bottomItem("assets/icons/consult.png", 2,
                    title: 'ปรึกษา'),
              ),
              Expanded(
                child: _bottomItem("assets/icons/appointment.png", 3,
                    title: 'นัดหมาย'),
              ),
              Expanded(
                child: _bottomItem("assets/icons/profile.png", 4,
                    title: 'โปรไฟล์'),
              )

              // _bottomItem(
              //   Icons.person,
              //   3,
              //   isImageUrl: true,
              //   title: 'โปรไฟล์',
              // ),
            ],
          ),
        ),
        //   ),
        // ),
      ),
    );
  }

  Future<bool> confirmExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'กดอีกครั้งเพื่อออก',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _bottomItem(
    String icon,
    int index, {
    bool isImageUrl = false,
    required String title,
  }) {
    final isSelected = _currentPage == index;
    return GestureDetector(
      onTap: () {
        // if (index == 2) {
        //   postTrackClick("แจ้งเตือน");
        // }
        setState(() {
          _currentPage = index;
        });
        // _loadUserProfile();
      },
      // borderRadius: BorderRadius.circular(50),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            // color:
            //     isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(45),
            // boxShadow: [
            //   BoxShadow(
            //     color:
            //         isSelected
            //             ? Colors.black.withOpacity(0.2)
            //             : Colors.transparent,
            //     blurRadius: 20,
            //     offset: Offset(0, 10),
            //   ),
            // ],
            // shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 28,
                height: 28,
                color: isSelected ? Colors.white : Color(0xFF666666),
              ),
              // isImageUrl
              // ? Container(
              //     // padding: EdgeInsets.all('${imageUrl}' != '' ? 0.0 : 5.0),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       // color: const Color(0xFFFF7900),
              //     ),
              //     alignment: Alignment.center,
              //     height: 30,
              //     width: 30,
              //     child: imageUrl != ''
              //         ? checkAvatar(context, '${imageUrl}')
              //         : Icon(
              //             icon,
              //             size: 30,
              //             color: isSelected
              //                 ? Color(0xFF011895)
              //                 : Color(0xFF877573),
              //           ),
              //   )
              // : Icon(
              //     icon,
              //     size: 30,
              //     color: isSelected ? Color(0xFF011895) : Color(0xFF877573),
              //   ),
              const SizedBox(
                height: 3,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : const Color(0xFF666666),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
