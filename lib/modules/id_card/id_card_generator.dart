import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'id_card_model.dart';

class IdCardGenerator {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<String?> generateIdCardImage(Widget idCardWidget) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${directory.path}/id_card_$timestamp.png';

      final image = await screenshotController.captureFromWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: idCardWidget),
          ),
        ),
        context: null,
        pixelRatio: ui.window.devicePixelRatio,
      );

      final file = File(path);
      await file.writeAsBytes(image);
      return path;
    } on PlatformException catch (e) {
      debugPrint('Failed to capture ID card: ${e.message}');
      return null;
    }
  }

  Future<bool> saveIdCardToGallery(String imagePath) async {
    try {
      // For Android: Would need to handle permissions and MediaStore
      // For iOS: Would need to handle permissions and PHPhotoLibrary
      // This is a simplified version
      final file = File(imagePath);
      final newPath = '${(await getExternalStorageDirectory())?.path}/id_card.png';
      await file.copy(newPath);
      return true;
    } catch (e) {
      debugPrint('Failed to save ID card: $e');
      return false;
    }
  }

  Future<Uint8List?> generateIdCardBytes(Widget idCardWidget) async {
    try {
      return await screenshotController.captureFromWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: idCardWidget),
          ),
        ),
        context: null,
        pixelRatio: ui.window.devicePixelRatio,
      );
    } catch (e) {
      debugPrint('Failed to generate ID card bytes: $e');
      return null;
    }
  }
}