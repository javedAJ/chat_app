// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:chat_app/colors.dart' as color;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickfn);

  final void Function(File? pickedImage) imagePickfn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();

// void imagePickFn(File file) {}
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    showDialog<ImageSource>(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Choose image source",
          style: TextStyle(color: color.AppColor.neavyblue),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            icon: Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            icon: const Icon(Icons.photo),
          ),
        ],
      ),
    ).then((ImageSource? source) async {
      if (source != null) {
        final pickedFile = await picker.getImage(source: ImageSource.camera);

        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
            widget.imagePickfn(_image);
          } else {
            print('No image selected.');
          }
        });
      }
    });

    // This is for single image picker method

    // final pickedFile = await picker.getImage(source: ImageSource.camera);

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //     widget.imagePickfn(_image);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: color.AppColor.red,
          radius: 40,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        FlatButton.icon(
          onPressed: getImage,
          icon: Icon(
            Icons.image,
            color: color.AppColor.red,
          ),
          label: Text(
            'Add Image',
            style: TextStyle(color: color.AppColor.red),
          ),
        ),
      ],
    );
  }
}
