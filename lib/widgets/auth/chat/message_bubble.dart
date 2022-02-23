import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart' as color;

class MessageBubble extends StatelessWidget {
  final String message;
  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.AppColor.red,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(
              color: color.AppColor.white1,
            ),
          ),
        ),
      ],
    );
  }
}
