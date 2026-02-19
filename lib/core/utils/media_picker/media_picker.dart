import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPicker {
  static Future<File?> pickImage() async {
    final granted = await Permission.photos.request();
    if (!granted.isGranted) return null;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<File?> pickVideo() async {
    final granted = await Permission.videos.request();
    if (!granted.isGranted) return null;

    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final statuses = await [
        Permission.camera,
        Permission.photos,
        Permission.videos,
      ].request();

      return statuses.values.every((status) => status.isGranted);
    } else {
      final status = await Permission.photos.request();
      return status.isGranted;
    }
  }

  static Future<File?> recordVideoFromCamera() async {
    final granted = await Permission.camera.request();
    if (!granted.isGranted) return null;

    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 2),
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  static Future<File?> takePictureFromCamera() async {
    final granted = await Permission.camera.request();
    if (!granted.isGranted) return null;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85, // optional (0–100)
      preferredCameraDevice: CameraDevice.rear,
    );

    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

}