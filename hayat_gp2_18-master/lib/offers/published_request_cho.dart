import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class publishedRequestCHO extends StatefulWidget {
  @override
  _publishedRequestCHO createState() => _publishedRequestCHO();
}

class _publishedRequestCHO extends State<publishedRequestCHO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker & Image Cropper"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade700),
                ),
                onPressed: () async {},
                child: Text("Select Image"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
