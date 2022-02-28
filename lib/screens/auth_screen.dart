import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart' as color;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Reference reference = FirebaseStorage.instance
        //     .ref()
        //     .child('user_image')
        //     .child(authResult.user!.uid + '.jpg');

        // UploadTask uploadTask = reference.putFile(image!);

        // uploadTask.whenComplete(() async {
        //   try {
        //     authResult = (await reference.getDownloadURL()) as UserCredential;
        //   } catch (error) {
        //     print(error);
        //   }
        //   print(authResult);
        // });

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + 'jpg');

        await ref.putFile(image!);

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } on FirebaseException catch (error) {
      var message = 'An error occurred , please check your credntials!';

      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
    // } catch (error) {
    //   print(error);
    //   var message = 'An error occurred , please check your credntials!';

    //   ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    //     content: Text(message),
    //     backgroundColor: color.AppColor.red,
    //   ));
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
