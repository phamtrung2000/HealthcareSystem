import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_mental_health/services/data_provider.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostProvider extends ChangeNotifier {
  List<String> imageList = ["http://asdasd.com/"];

  List<File> _listImage = [];
  Future submitPost(Function onComplete, String content, String title,
      String topicId, bool allowComment) async {
    try {
      await DataProvider().submitPost(
          allowComment: allowComment,
          content: content,
          title: title,
          topicId: topicId,
          imageUrls: _listImage.map((e) => e.path.toString()).toList());

      // show success dialog
      onComplete();
    } on DioError catch (e) {
      print(e.response);
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _listImage.add(File(image.path));
      notifyListeners();
    } on PlatformException catch (e) {
      print('$e');
    }
  }

  List<File> get listImage {
    return _listImage;
  }

  Future deleteImage(int index) async {
    _listImage.removeAt(index);
    notifyListeners();
  }
}
