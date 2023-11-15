import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freeman/src/router_helper.dart';

class MonitoringPage extends StatefulWidget {
  final String ipAddres;
  const MonitoringPage({super.key, required this.ipAddres});

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  bool isVRMode = false; // Track VR mode state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: isVRMode
                ? Row(
                    children: [
                      Expanded(child: _buildVRVideoFeed()),
                      Expanded(child: _buildVRVideoFeed()),
                    ],
                  )
                : _buildNormalVideoFeed(),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Routes.goToHome(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32.0,
                    ),
                  ),
                ),
                // _buildVRButton(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:   Positioned(
            bottom: 20,
            right: 20,
                  child: Row(

                    children: [
                       Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                   
                                    
                        Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                         
                          children: [
                                                 Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Icon(
                              Icons.electric_bolt_sharp,
                                color: Colors.white,
                              ),
                            ),
                         
                          ],
                        ),
                        
                    
                                    ],
                                  ),
                      ),
                      Spacer(),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                        Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton(Icons.arrow_upward),
                          ],
                        ),
                                    
                        Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                         
                          children: [
                            _buildButton(Icons.arrow_back),
                            SizedBox(height: 45,width: 45,),
                            //                      Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.black,
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     border: Border.all(
                            //       color: Colors.white,
                            //       width: 2.0,
                            //     ),
                            //   ),
                            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //   child: Icon(
                            //   Icons.circle_outlined,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            _buildButton(Icons.arrow_forward),
                          ],
                        ),
                        
                        Row(
                          
                           crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton(Icons.arrow_downward),
                          ],
                        )
                                    ],
                                  ),
                      ),
                    ],
                  ),
                )),
          

          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   // child: _buildConnectivityIndicator(),
          // ),
          // Center(child: Text(widget.ipAddres,style: TextStyle(color: Colors.blue,fontSize: 30),)),
        ],
      ),
    );
  }

  Widget _buildNormalVideoFeed() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Mjpeg(
            isLive: true,
            stream: 'http://192.168.50.175:81/stream',
            loading: (context) {
              // Change the color of the loading indicator here
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white), // Change the color here
                ),
              );
            },
           
           error: (context, error, stackTrace) {
  // Handle error condition here
  print('Error during streaming: $error');
  print('Stack trace: $stackTrace');
  return SvgPicture.asset(
    'assets/error.svg', // Replace with your SVG image
    width: MediaQuery.of(context).size.width * 0.25,
  );
},
          ),
        ),
      ),
    );
  }

  Widget _buildVRVideoFeed() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Mjpeg(
            isLive: true,
            stream: 'http://192.168.50.175:81/stream',
            loading: (context) {
              // Change the color of the loading indicator here
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white), // Change the color here
                ),
              );
            },
            error: (context, error, stackTrace) {
              // Handle error condition here
              return SvgPicture.asset(
                'assets/error.svg', // Replace with your SVG image
                width: MediaQuery.of(context).size.width * 0.25,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildConnectivityIndicator() {
    return const Icon(
      Icons.wifi_off,
      color: Colors.white,
      size: 48.0,
    );
  }

  Widget _buildVRButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isVRMode = !isVRMode;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isVRMode ? Colors.white : Colors.black,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isVRMode ? Colors.black : Colors.white,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          isVRMode ? 'VR OFF' : 'VR ON',
          style: TextStyle(
            color: isVRMode ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon) {
    return GestureDetector(
      onTap: () {
       
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
