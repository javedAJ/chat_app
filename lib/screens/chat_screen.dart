import 'package:chat_app/widgets/auth/chat/messages.dart';
import 'package:chat_app/widgets/auth/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/colors.dart' as color;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();

    FirebaseMessaging.onMessage.listen((msg) {
      print(msg);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.red,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: color.AppColor.neavyblue,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        color: color.AppColor.neavyblue,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(color: color.AppColor.neavyblue),
                      ),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdetifier) {
              if (itemIdetifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
        title: Text('Chats'),
      ),
      backgroundColor: color.AppColor.neavyblue,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}




//Stream builder of chat for refrence

// body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('chats/XjGKeIwW4K0wwb6Qp9w3/messages')
//             .snapshots(),
//         builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           final documents = streamSnapshot.data?.docs;
//           return ListView.builder(
//             itemCount: documents?.length,
//             itemBuilder: (context, index) => Container(
//               padding: const EdgeInsets.all(8),
//               child: Text(
//                 documents![index]['text'],
//                 style: TextStyle(fontSize: 20, color: color.AppColor.white1),
//               ),
//             ),
//           );
//         },
//       ),


//floating buttom

// floatingActionButton: FloatingActionButton(
//         backgroundColor: color.AppColor.red,
//         child: Icon(Icons.add),
//         onPressed: () {
//           FirebaseFirestore.instance
//               .collection('chats/XjGKeIwW4K0wwb6Qp9w3/messages')
//               .add({'text': 'This was addes by clicking the button'});
//         },
//       ),