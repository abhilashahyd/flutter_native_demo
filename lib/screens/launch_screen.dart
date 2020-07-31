import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_demo/widgets/take_picture_page.dart';
import 'package:flutter_native_demo/widgets/file_list_preview.dart';


class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  List<File> attachmentList = [];
// void  _launchCamera() {
//    _showCamera();
//  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final pickedImage = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      attachmentList.add(File(pickedImage));
      print(attachmentList);
    });
    // return result;
  }

  void _removeImage(File pickedFile) {
    setState(() {
      attachmentList.remove(pickedFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100,left: 130),
              child: RaisedButton(
              color:Colors.green,
                child:Text("Capture",style:TextStyle(color:Colors.white)),
                onPressed:() => _showCamera(),
              ),
            ),
            attachmentList.length >= 1
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: FileListPreview(attachmentList, _removeImage),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
