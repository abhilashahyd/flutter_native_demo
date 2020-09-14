import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class Faces extends StatefulWidget {
  final Function getFace;

  Faces(this.getFace);

  @override
  _FacesState createState() => _FacesState();
}

class _FacesState extends State<Faces> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
//  String _textValue = "sample";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10),
          child: Card(
            elevation: 18,
            child: Container(
                height: 90,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.face),
                    Text("Face Detect",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                )),
          )
//
          ),
      onTap: () => _face(),
    );
  }

  Future<Null> _face() async {
    List<Face> faces = [];
    int _cameraFace = FlutterMobileVision.CAMERA_FRONT;
    bool _autoFocusFace = true;
    bool _torchFace = false;
    bool _multipleFace = true;
    bool _showTextFace = true;
    Size _previewFace;
    List<Face> _faces = [];

    try {
      faces = await FlutterMobileVision.face(
        flash: _torchFace,
        autoFocus: _autoFocusFace,
        multiple: _multipleFace,
        showText: _showTextFace,
        preview: _previewFace,
        camera: _cameraFace,
        fps: 15.0,
      );
      // print(faces);
    } on Exception {
      faces.add(Face(-1));
    }

    if (!mounted) return;
    setState(() => _faces = faces);
    widget.getFace(_faces);
  }
}
