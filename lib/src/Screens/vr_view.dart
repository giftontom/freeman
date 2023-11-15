import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;


class CameraScreen extends StatelessWidget {
  final String streamUrl = 'http://192.168.46.175:81/stream'; // Replace with your ESP32 camera IP

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Camera Stream'),
      ),
      body:Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:Mjpeg(
                isLive: true,
                stream: 'http://192.168.46.175:81/stream',
                loading: (context) {
                  // Change the color of the loading indicator here
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Change the color here
                    ),
                  );
                },
      //           error: (context, error, stackTrace) {
      //             // Handle error condition here
      //             return  SvgPicture.asset(
      //   'assets/error.svg', // Replace with your SVG image
      //   width: MediaQuery.of(context).size.width * 0.25,
      // );
                // },
              ),
         
        ),
      ),
    ),
    );
  }
}