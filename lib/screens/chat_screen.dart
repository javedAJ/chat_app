import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/colors.dart' as color;

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.neavyblue,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/XjGKeIwW4K0wwb6Qp9w3/messages')
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                documents?[index]['text'],
                style: TextStyle(fontSize: 20, color: color.AppColor.white1),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.AppColor.red,
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/XjGKeIwW4K0wwb6Qp9w3/messages')
              .add({'text': 'This was addes by clicking the button'});
        },
      ),
    );
  }
}
