import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///To pick up image from gallery
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }

  return null;
}

///For display snackbars
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
      ),
    ),
  );
}

///Return parsed firebase error
String parseFirebaseError(String error) => error.toString().split(']')[1];

///Navigate to screen
void naviagateToScreen(BuildContext context, Widget screen) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => screen,
  ));
}
