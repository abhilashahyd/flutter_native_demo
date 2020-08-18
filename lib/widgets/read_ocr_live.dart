import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class ReadOCRLive extends StatefulWidget {
  final Function getValue;

  ReadOCRLive(this.getValue);

  @override
  _ReadOCRLiveState createState() => _ReadOCRLiveState();
}

class _ReadOCRLiveState extends State<ReadOCRLive> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "sample";
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: _read,
      child: Icon(
        Icons.chrome_reader_mode,
        color: Colors.white,
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    List<String> values = [];
    try {
      texts = await FlutterMobileVision.read(
        multiple: true,
        camera: _cameraOcr,
        waitTap: true,
      );
      print(texts);
      print('bottom ${texts[3].bottom}');
      print('top ${texts[2].top}');
      print('left ${texts[4].left}');
      print('top ${texts[3].right}');
      print('top ${texts[1].language}');

      texts.forEach((val) => {
//             print(val.value),
            values.add(val.value.toString()),
          });
//      widget.getValue(values);
      if (!mounted) return;
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
}
