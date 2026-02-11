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
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> messages = [];

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = chatController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(
        text: text,
        isMe: true,
      ));
    });

    chatController.clear();

    // scroll ลงล่าง
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(ChatMessage(
          text: 'รับทราบครับ 👍',
          isMe: false,
        ));
      });
    });
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
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return Align(
                    alignment:
                        msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        !msg.isMe
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  widget.model['imageUrl'] ?? '',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          // margin: const EdgeInsets.symmetric(vertical: 4),
                          // padding: const EdgeInsets.all(12),
                          // decoration: BoxDecoration(
                          //   color: msg.isMe
                          //       ? Colors.blueAccent
                          //       : Colors.grey.shade300,
                          //   borderRadius: BorderRadius.circular(16),
                          // ),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: msg.isMe
                                ? const Color(0xFF00B900)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: msg.isMe
                                  ? const Radius.circular(18)
                                  : const Radius.circular(4),
                              bottomRight: msg.isMe
                                  ? const Radius.circular(4)
                                  : const Radius.circular(18),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color: msg.isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
            onSubmitted: (value) => _sendMessage(),
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
                    ? GestureDetector(
                        onTap: () => _sendMessage(),
                        child: const Icon(
                          Icons.send,
                          size: 26,
                          color: Color(0xFF0262EC),
                        ),
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

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.isMe,
  });
}
