import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'id_card_model.dart';
import 'id_card_generator.dart';
import 'qr_code_widget.dart';

class IdCardScreen extends StatefulWidget {
  final IdCard idCard;

  const IdCardScreen({super.key, required this.idCard});

  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final IdCardGenerator _idCardGenerator = IdCardGenerator();
  bool _isSaving = false;

  Future<void> _saveIdCard() async {
    setState(() => _isSaving = true);
    try {
      final imagePath = await _idCardGenerator.generateIdCardImage(
        _buildIdCardWidget(),
      );
      
      if (imagePath != null) {
        final saved = await _idCardGenerator.saveIdCardToGallery(imagePath);
        if (saved && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ID Card saved to gallery')),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildIdCardWidget() {
    return Container(
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          // Header with institution logo
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Center(
              child: Text(
                'INSTITUTION NAME',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Profile photo
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.idCard.photoUrl),
              backgroundColor: Colors.grey[200],
            ),
          ),
          
          // User details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.idCard.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.idCard.department,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'ID: ${widget.idCard.id}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          // QR Code
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: QrCodeWidget(
              data: widget.idCard.qrData,
              size: 120,
            ),
          ),
          
          // Expiry date
          Text(
            'Valid until: ${widget.idCard.expiryDate.year}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual ID Card'),
        actions: [
          IconButton(
            icon: _isSaving 
                ? const CircularProgressIndicator()
                : const Icon(Icons.download),
            onPressed: _isSaving ? null : _saveIdCard,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: _screenshotController,
                child: _buildIdCardWidget(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveIdCard,
                child: const Text('Save to Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}