import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;



class ImageText extends StatefulWidget {
  @override
  _ImageTextState createState() => new _ImageTextState();
}

class _ImageTextState extends State<ImageText> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  File imageFile;

  Future getImage(context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    print(image);
    image = imageLib.copyResize(image, width: 600);
    print(image);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter Example"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      print(imageFile.path);
    }
    var file = imagefile['image_filtered'].readAsBytesSync();
    String img64 = base64Encode(file);
    var url = 'https://api.ocr.space/parse/image';
    var apikey = 'a1c4a5549088957';
    var payload = { "base64Image": "data:image/jpg;base64,${img64.toString()}"};
    var header = {"apikey":apikey};
    var post =await http.post(url, body: payload,  headers: header);
    var result = jsonDecode(post.body);

    print(result);
    print(result['ParsedResults'][0]['ParsedText']);
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Photo Filter Example'),
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
            child: new Text('No image selected.'),
          )
              : Image.file(imageFile),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}