import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_demo/widgets/flutter_bluetooth.dart';
import 'package:flutter_native_demo/widgets/opencv.dart';
import 'package:flutter_native_demo/widgets/screen_rec.dart';
import 'package:flutter_native_demo/widgets/take_picture_page.dart';
import 'package:flutter_native_demo/widgets/file_list_preview.dart';
import 'package:flutter_native_demo/widgets/make_a_call.dart';
import 'package:flutter_native_demo/widgets/read_ocr_live.dart';


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

  Function getValue(List<String> values) {
//    values.forEach((element) {print(element);});
//    print(values);
    //You can include logic to handle the values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Flutter Native Demo")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 40,left: 10),
                      child: Card(
                        elevation: 15,
                        child: Container(
                            height: 90,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera),
                                Text("Launch Camera",
                                    style: TextStyle(fontWeight: FontWeight.bold))
                              ],
                            )),
                      )
//              child: RaisedButton(
//              color:Colors.green,
//                child:Text("Capture",style:TextStyle(color:Colors.white)),
//                onPressed:() => _showCamera(),
//              ),
                  ),
                  onTap: () => _showCamera(),
                ),

                MakeACall(),
                ReadOCRLive(getValue),
                attachmentList.length >= 1
                    ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: FileListPreview(attachmentList, _removeImage),
                )
                    : SizedBox(),
          ],

        ),
Row(
  children: [
    GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Card(
              elevation: 15,
              child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bluetooth),
                      Text("Bluetooth",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
            )
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlutterBlueApp()))
        ),
    GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Card(
              elevation: 15,
              child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      Text("OpenCv",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
            )
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OpenCv()))
    ),
    GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: Card(
              elevation: 15,
              child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.videocam),
                      Text("ScreenRec",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
            )
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScreenRec()))
    ),

      ],
  )
          ],
        ),
      ),
    );
  }
}
