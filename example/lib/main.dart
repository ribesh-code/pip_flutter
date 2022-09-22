import 'package:flutter/material.dart';
import 'package:pip_flutter/pip_flutter.dart';
import 'package:video_player/video_player.dart';

/// Some aspect ratio presets to choose
const aspectRatios = [
  [1, 1],
  [2, 3],
  [3, 2],
  [16, 9],
  [9, 16],
];
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool pipAvailable = false;
  List<int> aspectRatio = aspectRatios.first;
  bool autoPipAvailable = false;
  bool autoPipSwitch = false;
  late Helper helper;
  late PipFlutter pip;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    pip = PipFlutter();
    requestPlatform();
    _controller = VideoPlayerController.asset('assets/videos/download.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  Future<void> requestPlatform() async {
    var isAvaiable = await Helper.isPipAvaiable;
    var isAutoPipAvaiable = await Helper.isAutoPipAvaible;
    setState(() {
      pipAvailable = isAvaiable;
      autoPipAvailable = isAutoPipAvaiable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Pip widget can build different widgets for each mode
      home: PipModeWidget(
        // builder is null so child is used when not in pip mode
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pip Plugin example app'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Text('Pip is ${pipAvailable ? '' : 'not '}Available'),
              DropdownButton<List<int>>(
                value: aspectRatio,
                onChanged: (List<int>? newValue) {
                  if (newValue == null) return;
                  if (autoPipSwitch) {
                    Helper.setAutoPipMode(
                      aspectRatio: newValue,
                      seamlessResize: true,
                    );
                  }
                  setState(() {
                    aspectRatio = newValue;
                  });
                },
                items: aspectRatios
                    .map<DropdownMenuItem<List<int>>>(
                      (List<int> value) => DropdownMenuItem<List<int>>(
                        child: Text('${value.first} : ${value.last}'),
                        value: value,
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Auto Enter (Android S): '),
                  Switch(
                    value: autoPipSwitch,
                    onChanged: autoPipAvailable
                        ? (newValue) {
                            setState(() {
                              autoPipSwitch = newValue;
                            });
                          }
                        : null,
                  ),
                ],
              ),
              IconButton(
                onPressed: pipAvailable
                    ? () => Helper.enterPipMode(
                          aspectRatio: aspectRatio,
                        )
                    : null,
                icon: const Icon(Icons.picture_in_picture),
              ),
            ],
          ),
        ),
        // pip builder is null so pip child is used when in pip mode
        pipChild: Scaffold(
          body: Center(
            child: (_controller.value.isInitialized)
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  )
                : Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
