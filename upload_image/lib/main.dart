import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;
  TextEditingController codeController =
      TextEditingController(text: "Awesome code controller");
  TextEditingController odoController = TextEditingController(text: "314159");
  TextEditingController restultController =
      TextEditingController(text: "Result 👋");
  TextEditingController jwtController = TextEditingController();

  Future<void> _uploadData() async {
    if (_imageFile == null) {
      // No image selected
      return;
    }

    final imageData = _imageFile!.readAsBytesSync();

    final payload = jsonEncode(<String, Object>{
      "code": codeController.text,
      "odometer": int.parse(odoController.text),
      "result": restultController.text,
      "photo": base64Encode(imageData),
      "photoContentType": "string",
      "completed": "2024-01-18T08:13:30.916Z"
    });

    final headers = <String, String>{
      "accept": "*/*",
      "Content-Type": "application/json",
      "Authorization": "Bearer ${jwtController.text}",
    };

    final response = await http.post(
        Uri.parse('http://localhost:8080/api/inspections'),
        headers: headers,
        body: payload);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful upload
        print('Uploaden geslaagd...: ${response.statusCode}');
      } else {
        // Handle failed upload
        print('Uploaden niet geslaagd. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print('Error: $error');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_getFileInput(), _getTextFields()],
        ),
      ),
    );
  }

  Widget _getFileInput() {
    return Column(children: <Widget>[
      _imageFile == null
          ? const Text('Geen plaatje geselecteerd.')
          : Image.file(_imageFile!),
      ElevatedButton(
        onPressed: _pickImage,
        child: const Text("Selecteer een plaatje"),
      ),
      ElevatedButton(
        onPressed: _uploadData,
        child: const Text('Upload de data'),
      )
    ]);
  }

  Widget _getTextFields() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          TextFormField(
              controller: codeController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'code',
              )),
          TextFormField(
              controller: odoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'odometer',
              )),
          TextFormField(
              controller: restultController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'result',
              )),
          TextFormField(
              controller: jwtController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'kopieer hier JWT uit de swagger docs',
              ))
        ]));
  }
}
