import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart' as color;
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (context, index) => Text(
            chatDocs![index]['text'],
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
