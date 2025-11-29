import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/mixines/safe_notify_mixines.dart';

class ProfileController extends ChangeNotifier with SafeNotifyMixines {
  XFile? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        selectedImage = pickedFile;

        await PreferencesManager().setString("image", selectedImage!.path);

        notify();
      } else {
        debugPrint("No image selected.");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  File? getImageFile() {
    if (selectedImage != null) {
      return File(selectedImage!.path);
    }

    final path = PreferencesManager().getString("image");
    if (path != null && path.isNotEmpty && File(path).existsSync()) {
      return File(path);
    }

    return null; 
  }
}
