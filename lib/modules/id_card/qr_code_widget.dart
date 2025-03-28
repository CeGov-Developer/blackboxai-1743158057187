import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const QrCodeWidget({
    super.key,
    required this.data,
    this.size = 120,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: size,
      gapless: true,
      foregroundColor: foregroundColor ?? Theme.of(context).primaryColor,
      backgroundColor: backgroundColor ?? Colors.transparent,
      embeddedImage: const AssetImage('assets/logo.png'),
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(size * 0.2, size * 0.2),
      ),
      errorStateBuilder: (cxt, err) {
        return Center(
          child: Text(
            'QR Error: $err',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}