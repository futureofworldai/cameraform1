import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const Myhomepage(title: 'Camera Home Page'),
    );
  }
}

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key, required String title});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  Uint8List? _file;
  String? _text;

  _imageSelect(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select Image'),
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(
                        255, 251, 252, 252)), // Set the background color here
              ),
              child: const Text('Select disaster photo from gallery'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(
                        255, 251, 252, 252)), // Set the background color here
              ),
              child: const Text('Take disaster photo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 251, 252, 252),
                ),
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('post image'),
        ),
        body: _file == null
            ? Center(
                child: Column(
                  children: [
                    Positioned(
                      top: 50,
                      bottom: 50,
                      left: 50,
                      child: InkWell(
                        onTap: () => _imageSelect(context),
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a disaster name and its description',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _text = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_text != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        _text!,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                    ElevatedButton(
                              onPressed: () {
                                // Do something when the text button is pressed.
                              },
                              child: const Text('Send Text'),
                            ),
                  ],
                ),
              )
            : Center(
                child: Column(
                children: [
                  const Divider(),
                  SizedBox(
                      height: 300,
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter),
                        ),
                      ))
                ],
              )));
  }
}
