import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class SignatureDetectionScreen extends StatefulWidget {
  const SignatureDetectionScreen({Key? key}) : super(key: key);

  @override
  State<SignatureDetectionScreen> createState() =>
      _SignatureDetectionScreenState();
}

class _SignatureDetectionScreenState extends State<SignatureDetectionScreen> {
  bool imageLabelChecking = false;
  bool detected = false;

  XFile? imageFile;

  String imageLabel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Image Label example"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (imageLabelChecking) const CircularProgressIndicator(),
                if (!imageLabelChecking && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null)
                  Image.file(
                    File(imageFile!.path),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  imageLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: detected ? Colors.green : Colors.red),
                )
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageLabelChecking = true;
        imageFile = pickedImage;
        setState(() {});
        print('Still here');
        getImageLabels(pickedImage);
      }
    } catch (e) {
      imageLabelChecking = false;
      imageFile = null;
      imageLabel = "Error occurred while getting image Label+$e";
      print(e);
      setState(() {});
    }
  }

  void getImageLabels(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    ImageLabeler imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.75));
    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    StringBuffer sb = StringBuffer();
    for (ImageLabel imgLabel in labels) {
      String lblText = imgLabel.label;
      double confidence = imgLabel.confidence;
      // sb.write(lblText);
      // sb.write(" : ");
      // sb.write((confidence * 100).toStringAsFixed(2));
      // sb.write("%\n");
      if (lblText == 'Paper') {
        sb.write("Signature Detected");
        detected = true;
        break;
      }
    }
    if (!detected) {
      sb.write("No Signature Detected");
      detected = false;
    }
    imageLabeler.close();
    imageLabel = sb.toString();
    imageLabelChecking = false;
    setState(() {});
  }
}
