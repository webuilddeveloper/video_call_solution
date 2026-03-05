import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  dynamic selectedImage; // 👈 เก็บแบบ dynamic

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image; // เก็บ XFile
      });

      print("ชื่อไฟล์: ${selectedImage.name}");
      print("path: ${selectedImage.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("เลือกรูป")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("เลือกรูปจากแกลเลอรี่"),
            ),

            const SizedBox(height: 20),

            /// แสดง preview
            if (selectedImage != null)
              Image.file(
                File(selectedImage.path),
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}
