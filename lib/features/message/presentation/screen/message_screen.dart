
import 'package:flutter/material.dart';

class ChatPageSample extends StatelessWidget {
  const ChatPageSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Office",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Text(
              "Last Seen Yesterday at 15:16",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _sentBubble(
                  text: "Hi Sara 👋",
                  time: "11:31 AM",
                  seen: true,
                ),
                const SizedBox(height: 12),
                _sentBubble(
                  text: "Can you tell me what Sophia’s challenge was today?",
                  time: "11:31 AM",
                  seen: true,
                ),
                const SizedBox(height: 12),
                _receivedBubble(
                  name: "Sara",
                  text:
                  "Today, Sophia’s challenge was sharing toys with her classmates. We worked on taking turns, and she did much better by the end of the day.",
                  time: "11:31 AM",
                  seen: true,
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "Today",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 12),
                _sentBubble(
                  text: "Hi Sara 👋",
                  time: "11:31 AM",
                  seen: false,
                ),
              ],
            ),
          ),

          // Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.image_outlined, color: Colors.grey, size: 28),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Start typing...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFF7C4DFF),
                  child: Icon(Icons.send, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sentBubble({
    required String text,
    required String time,
    required bool seen,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFF9C4DFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
              SizedBox(width: 4),
              Text(
                seen ? "• Seen" : "• Unseen",
                style: TextStyle(
                  color: seen ? Colors.grey : Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _receivedBubble({
    required String name,
    required String text,
    required String time,
    required bool seen,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[400],
        ),
        SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0EB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      text,
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Text(
                "$time • Seen",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }
}
