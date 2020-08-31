import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter/material.dart';
class BarCode extends StatefulWidget {
  final Function getResult;
  BarCode(this.getResult);
  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  @override
  int _cameraBarcode = FlutterMobileVision.CAMERA_BACK;
  int _onlyFormatBarcode = Barcode.ALL_FORMATS;
  bool _autoFocusBarcode = true;
  bool _torchBarcode = false;
  bool _multipleBarcode = false;
  bool _waitTapBarcode = false;
  bool _showTextBarcode = false;
  Size _previewBarcode;
  List<Barcode> _barcodes = [];
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
                    Icon(Icons.scanner),
                    Center(child: Text("QrScanner", style: TextStyle(fontWeight: FontWeight.bold,)))
                  ],
                )),
          )
//
      ),
      onTap: () => _scan(),
    );
  }


  Future<Null> _scan() async {
    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        flash: _torchBarcode,
        autoFocus: _autoFocusBarcode,
        formats: _onlyFormatBarcode,
        multiple: _multipleBarcode,
        waitTap: _waitTapBarcode,
        showText: _showTextBarcode,
        preview: _previewBarcode,
        camera: _cameraBarcode,
        fps: 15.0,
      );
    } on Exception {
      barcodes.add(Barcode('Failed to get barcode.'));
    }


    if (!mounted) return;
    setState(() => _barcodes = barcodes);
    widget.getResult(_barcodes);
  }
}