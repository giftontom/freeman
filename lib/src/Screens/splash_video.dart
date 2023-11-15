import 'package:flutter/material.dart';
import 'package:freeman/src/Screens/home.dart';
import 'package:video_player/video_player.dart';

class SplahVideo extends StatefulWidget {
  @override
  _SplahVideoState createState() => _SplahVideoState();
}

class _SplahVideoState extends State<SplahVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and then play the video
        setState(() {});
        _controller.play();
        // Add a listener to detect when the video has finished playing
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            // Video has finished playing, navigate to the home screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(), // Replace with your home screen widget
              ),
            );
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height ,
              child: Center(
                child: _controller.value.isInitialized
                    ? FractionallySizedBox(
                      heightFactor: 1.5,
                        widthFactor: 0.75, // Make video width take up entire width
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
             Container(
              
               child: Positioned(
                 width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height ,
               
                left:  (MediaQuery.of(context).size.width *0.5)-(25),
                top:  MediaQuery.of(context).size.height *0.7,
                child: Text("Loading . . .",
                
                style: TextStyle(
                  fontFamily: "KayPhoDuFamily",
                fontSize: 20,
                fontWeight: FontWeight.w600,
                  color: Colors.white),)),
             )
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant SplahVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.value.position == _controller.value.duration) {
      // Video has finished playing, navigate to the home page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(), // Navigate to the Home Page
        ),
      );
    }
  }
}
