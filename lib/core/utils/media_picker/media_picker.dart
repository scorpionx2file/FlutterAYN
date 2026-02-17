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
    Permission permissionImages = Permission.photos;
    Permission permissionVideos = Permission.videos;

    if (Platform.isAndroid) {
      permissionImages = Permission.photos;
      permissionVideos = Permission.videos;
    }

    Map<Permission, PermissionStatus> statuses = await [
      permissionImages,
      permissionVideos
    ].request();

    bool grantedImages = statuses[permissionImages]?.isGranted ?? false;
    bool grantedVideos = statuses[permissionVideos]?.isGranted ?? false;

    return grantedImages && grantedVideos;
  }

}