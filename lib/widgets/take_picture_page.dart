import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePicturePage extends StatefulWidget {
  final CameraDescription camera;
  TakePicturePage({@required this.camera});

  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  final fileName = DateTime.now().millisecondsSinceEpoch.toString();
  var vidPath;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  int _selectedIndex = 0;
  bool _start = false;
  bool _isRec = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        _start = !_start;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _initializeCameraControllerFuture = _cameraController.initialize();
    _fileInit();
  }

  void _fileInit() async {
    vidPath = join((await getTemporaryDirectory()).path, '${fileName}.mp4');
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;

      if (_selectedIndex == 0) {
        final imgPath =
            join((await getTemporaryDirectory()).path, '${fileName}.png');
        await _cameraController.takePicture(imgPath);
        Navigator.pop(context, imgPath);
      } else {
        if (_start) {
          await _cameraController.startVideoRecording(vidPath);
          setState(() {
            _start = !_start;
            _isRec = !_isRec;
          });
        } else {
          _cameraController.stopVideoRecording();
          setState(() {
            _isRec = !_isRec;
          });
          Navigator.pop(context, vidPath);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.green,));
              }
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  child:   _selectedIndex == 1 ? _isRec == true?Icon(Icons.pause, color: Colors.white):Icon(Icons.play_arrow, color: Colors.white) : Icon(Icons.camera, color: Colors.white),
                  onPressed: () {
                    _takePicture(context);
                  },
                ),
              ),
            ),
          ),
          _isRec == true
              ? SafeArea(
                  child: Container(
                    height: 30,
                    // alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Color(0xFFEE4400),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "REC",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFFFAFAFA)),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Picture'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            title: Text('Video'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
