import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/component/appbar.dart';

class MessageFormPage extends StatefulWidget {
  MessageFormPage({Key? key, this.model});

  dynamic model;

  @override
  State<MessageFormPage> createState() => _MessageFormPageState();
}

class _MessageFormPageState extends State<MessageFormPage> {
  final TextEditingController chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F5),
      appBar: appBarCustom(
        title: "",
        backBtn: true,
        isRightWidget: true,
        backAction: () => goBack(),
        rightWidget: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.model['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.model['active'] ? 'Active Now' : 'Not Active',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8593A8)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    widget.model['imageUrl'] ?? '',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                widget.model['active']
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
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(chatController.text)
          ],
        ),
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Container(
          color: const Color(0xFFEEF2F5),
          // padding: EdgeInsets.fromLTRB(15, 0, 15, isKeyboardOpen ? 15 : 0),
          padding: EdgeInsets.only(
              left: 15, right: 15, bottom: isKeyboardOpen(context) ? 15 : 25),
          child: TextField(
            controller: chatController,
            maxLines: null,   
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {});
            },
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15.00,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFFFFF),
              contentPadding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 10.0),
              hintText: "พิมพ์ข้อความ...",
              helperStyle: const TextStyle(
                color: Color(0xFF8593A8),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(8, 13, 15, 13),
                child: chatController.text.isNotEmpty
                    ? const Icon(
                        Icons.send,
                        size: 26,
                        color: Color(0xFF0262EC),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/input-gallery.png',
                            width: 26,
                            height: 26,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Image.asset(
                            'assets/icons/input-emoji.png',
                            width: 26,
                            height: 26,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                // borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Color(0xFF0262EC)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: const BorderSide(color: Color(0xFF0262EC)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  void goBack() async {
    Navigator.pop(context, false);
  }
}
