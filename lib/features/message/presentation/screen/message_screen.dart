import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../resorces/pallete.dart';

class Message {
  final String text;
  final String time;
  final bool isSender;
  final bool seen; // اضافه شد

  Message({
    required this.text,
    required this.time,
    required this.isSender,
    this.seen = true,
  });
}


class ChatPageSample extends StatelessWidget {
  ChatPageSample({super.key});

  final List<Message> messages = [
    Message(text: "Hi Sara 👋", time: "11:31 AM", isSender: true, seen: true),
    Message(text: "Can you tell me what Sophia’s challenge was today?", time: "11:32 AM", isSender: true, seen: true),
    Message(text: "Today, Sophia’s challenge was sharing toys with her classmates.", time: "11:33 AM", isSender: false),
    Message(text: "Another message from sender", time: "11:34 AM", isSender: true, seen: false),
    Message(text: "Second message from sender", time: "11:35 AM", isSender: true, seen: false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Office",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Text("Last Seen Yesterday at 15:16",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Palette.bgBackground90,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final showAvatar = index == 0 || messages[index - 1].isSender != message.isSender;
                  final isFirstOfSender = index == 0 || messages[index - 1].isSender != message.isSender;

                  // اگر پیام بعدی از همان فرستنده باشد، showStatus = false برای پیام اول
                  bool showStatus = true;
                  if (index < messages.length - 1 &&
                      messages[index].isSender &&
                      messages[index + 1].isSender) {
                    showStatus = false; // پیام اول پشت سر هم دیده نشود
                  }

                  if (message.isSender) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _senderMessage(
                        text: message.text,
                        seen: message.seen,
                        showAvatar: showAvatar,
                        isFirstOfSender: isFirstOfSender,
                        showStatus: showStatus,
                      ),
                    );
                  } else {
                    // برای گیرنده هم مشابه می‌توانید اضافه کنید
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _receiverMessage(
                        name: "Sara",
                        text: message.text,
                        time: message.time,
                        showAvatar: showAvatar,
                        isFirstOfReceiver: isFirstOfSender,
                      ),
                    );
                  }
                },

              ),
            ),

            // Input
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/ic_attach.svg'),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Palette.bgBackground90,
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Start typing...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              print("Send button tapped");
                            },
                            child: SvgPicture.asset('assets/images/ic_send_msg.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _senderMessage({
    required String text,
    required bool seen,
    required bool showAvatar,
    required bool isFirstOfSender,
    required bool showStatus, // اضافه شد
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: seen ? Color(0xFFF0E7FF) : Color(0xFF9C4DFF),
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(20),
                    topRight: Radius.circular(isFirstOfSender ? 6 : 20),
                    bottomLeft: Radius.circular(20),
                    bottomRight:Radius.circular(20),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: seen ?Palette.textForeground : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (showStatus) // فقط اگر این پیام آخر یا دوم باشد نمایش بده
                SizedBox(height: 4),
              if (showStatus)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("11:31 AM", style: TextStyle(color: Palette.textForeground,
                        fontSize: 12,fontWeight: FontWeight.w400)),
                    SizedBox(width: 4),
                    Text(
                      seen ? "• Seen" : "• Unseen",
                      style:  TextStyle(color: Palette.textForeground,
                      fontSize: 12,fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
            ],
          ),
        ),
        showAvatar
            ? CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage("assets/images/avatar2.png"),
        )
            : SizedBox(width: 36),
      ],
    );
  }



  Widget _receiverMessage({
    required String name,
    required String text,
    required String time,
    required bool showAvatar,
    required bool isFirstOfReceiver,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showAvatar)
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/avatar1.png"),
          ),
        if (showAvatar) SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0EB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isFirstOfReceiver ? 6 : 20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showAvatar)
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                    if (showAvatar) SizedBox(height: 4),
                    Text(text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text("$time • Seen",
                  style: TextStyle(color: Palette.textForeground,
                      fontSize: 12,fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
