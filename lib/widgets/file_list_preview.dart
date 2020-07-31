import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

class FileListPreview extends StatelessWidget {
  const FileListPreview(
    @required this.attachmentList,
    @required this.removeImage,
  );

  final List<File> attachmentList;
  final Function removeImage;

  @override
  Widget build(BuildContext context) {
    const filepath = "assets/images/video.png";

    return SingleChildScrollView(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
//                      children: attachmentList.map((File attachFile) {
          // return new  Container(child: FileImage(attachFile));
          children: [
            Container(
              height: 100,
              width: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: attachmentList.length,
                itemBuilder: (BuildContext context, int index) {
                  var extn = attachmentList[index].toString().substring(
                      attachmentList[index].toString().lastIndexOf('.'),
                      attachmentList[index].toString().length - 1);

                  return Stack(
                    children: [
                      (extn == ".jpg" || extn == ".jpeg" || extn == ".png"
                          ? new Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(attachmentList[index])
                                    //   image: new FileImage(attachFile),
                                    ),
                              ),
                            )
                          : (extn == '.mp4'
                              ? Container(
                                  width: 100.0,
                                  height: 100.0,
                                  //  child:Icon(Icons.videocam,size: 40,))
                                  child: Image(
                                    image: AssetImage(filepath),
                                    fit: BoxFit.scaleDown,
                                  ))
                              : Material(
                                  type: MaterialType.transparency,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "File ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Icon(Icons.insert_drive_file)
                                          ]),
                                    ),
                                  ),
                                ))),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => removeImage(attachmentList[index]),
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ]),
    );
  }
}
