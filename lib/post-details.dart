import 'package:flutter/material.dart';
import 'package:LawyerOnline/component/appbar.dart';
import 'package:LawyerOnline/lawyer-online-details.dart';

class PostDetails extends StatefulWidget {
  PostDetails({Key? key, this.model});

  dynamic model;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  dynamic model;

  @override
  void initState() {
    // canPop = false;
    callRead();
    super.initState();
  }

  callRead() {
    setState(() {
      model = widget.model;
      print(model['lawyerModel']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBar(
        title: "รายละเอียดโพสต์",
        backBtn: true,
        rightBtn: false,
        backAction: () => goBack(),
        rightAction: () => {},
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        children: [
          const SizedBox(
            height: 20,
          ),
          _postCard(),
          model['lawyerApprove'] ? const SizedBox(
            height: 20,
          ) : Container(),
          model['lawyerApprove'] ?
          _lawyerCard() : Container(),
          // _bookingCard(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _postCard() {
    return Container(
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
                                      ? const Color.fromARGB(255, 240, 216, 39)
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
              // maxLines: 4,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  _lawyerCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawyerOnlineDetails(code: model['lawyerModel']['code'],),
                  ),
                );
        
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // BG ซ้าย
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/bg-lawyer-card-left.png',
                      height: constraints.maxHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
      
                  // BG ขวา
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/bg-lawyer-card-right.png',
                      height: constraints.maxHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
      
                  // AVATAR
                  Positioned(
                    right: 0,
                    top: 10,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/avatar-lawyer-card.png',
                      height: constraints.maxHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
      
                  // CONTENT CARD
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'ทนายที่รับเรื่อง',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                model['name'] ?? '-',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              // const SizedBox(height: 10),
                              Text(
                                '${model['lawyerModel']['scroll'] ?? 0} ⭐',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: model['lawyerModel']['scroll'] >= 5
                                      ? const Color(0xFF0262EC)
                                      : model['lawyerModel']['scroll'] >= 3
                                          ? const Color.fromARGB(255, 75, 190, 18)
                                          : model['lawyerModel']['scroll'] >= 2
                                              ? const Color.fromARGB(
                                                  255, 200, 200, 26)
                                              : Color.fromARGB(255, 226, 59, 30),
                                ),
                              ),
                              
                              const SizedBox(height: 10),
                              Text(
                                '${model['lawyerModel']['cost']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  btmCard(
                                      icon: "assets/icons/phone.png",
                                      action: () {}),
                                  const SizedBox(width: 15),
                                  btmCard(
                                      icon: "assets/icons/videocall.png",
                                      action: () {}),
                                  const SizedBox(width: 15),
                                  btmCard(
                                      icon: "assets/icons/chat.png",
                                      action: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dateItem({dynamic date, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
          width: 53,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.8),
            border: Border.all(
              width: 1,
              color: const Color(0xFFDBDBDB),
            ),
          ),
          child: Column(
            children: [
              Text(
                date['num'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date['text'],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.5)),
              ),
            ],
          )),
    );
  }

  Widget scoreItem({
    String? icon,
    required String? title,
    required String? value,
  }) {
    return Container(
        width: 110,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon!,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    value!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title!,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ));
  }

  Widget socialItem({String? icon, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 12,
        //   vertical: 10,
        // ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Image.asset(
          icon!,
          width: 18,
          height: 18,
        ),
      ),
    );
  }

  Widget btmCard({String? icon, Function? action}) {
    return GestureDetector(
      onTap: () => action!(),
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 12,
        //   vertical: 10,
        // ),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12.8),
          border: Border.all(
            width: 1,
            color: const Color(0xFFDBDBDB),
          ),
        ),
        child: Image.asset(
          icon!,
          width: 16,
          height: 16,
        ),
      ),
    );
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
