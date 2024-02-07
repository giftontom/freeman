import 'package:back_pressed/back_pressed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freeman/src/router_helper.dart';
import 'package:http/http.dart' as http;

class MonitoringPage extends StatefulWidget {
  final String ipAddres;
  const MonitoringPage({super.key, required this.ipAddres});

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  bool isVRMode = false; // Track VR mode state
 bool holdingButton = false;

      Future<void> _sendCommand(String command) async {
    try {
      final response = await http.get(
        Uri.parse('http://${widget.ipAddres+command}'),
      );

      if (response.statusCode == 200) {
        print('Command sent successfully: $command');
      } else {
        print('Failed to send command: http://${widget.ipAddres+command}');
      }
    } catch (error) {
      print('Error sending command: $error');
    }
      }
      Future<void> _delayedStop() async {
    await Future.delayed(Duration(milliseconds:200 ));
    await _sendCommand('/stop');
  }
    
    void _startCommand() {
    _sendCommand("/ledon");
    holdingButton = true;
  }

  void _stopCommand() {
    if (holdingButton) {
      _sendCommand("/ledoff");
      holdingButton = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
    perform:  () => Routes.pushNamedAndRemoveUntil(Routes.home),
    child:Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: isVRMode
                ? const Row(
                    children: [
                      // Expanded(child: _buildVRVideoFeed()),
                      // Expanded(child: _buildVRVideoFeed()),
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
                  onTap: () => Routes.pushNamedAndRemoveUntil(Routes.home),
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
                                                 GestureDetector(
                                                  
     onTapDown: (_) => _startCommand(),
              onTapUp: (_) => _stopCommand(),
                                                   child: Container(
                                                                               decoration: BoxDecoration(
                                                                                 color: Colors.black,
                                                                                 shape: BoxShape.circle,
                                                                                 border: Border.all(
                                                                                   color: Colors.white,
                                                                                   width: 2.0,
                                                                                 ),
                                                                               ),
                                                                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                               child: const Icon(
                                                                               Icons.electric_bolt_sharp,
                                                                                 color: Colors.white,
                                                                               ),
                                                                             ),
                                                 ),
                         
                          ],
                        ),
                        
                    
                                    ],
                                  ),
                      ),
                      const Spacer(),
                      
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
                            _buildButton(Icons.arrow_upward,"/go"),
                          ],
                        ),
                                    
                        Row(
                             crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                         
                          children: [
                            _buildButton(Icons.arrow_back, "/left"),
                            const SizedBox(height: 45,width: 45,),
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
                            _buildButton(Icons.arrow_forward,"/right"),
                          ],
                        ),
                        
                        Row(
                          
                           crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton(Icons.arrow_downward,"/back"),
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
      ),),
    );
  }

  Widget _buildNormalVideoFeed() {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
          child: Expanded(
            child: Mjpeg(
              fit:BoxFit.fill,
              isLive: true,
              stream: 'http://${widget.ipAddres}:81/stream',
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  'assets/error.svg', // Replace with your SVG image
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            );
          },
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildVRVideoFeed() {
  //   return Container(
  //     color: Colors.black,
  //     child: Expanded(
  //       child: Mjpeg(
  //         isLive: true,
  //         stream: 'http://192.168.50.175:81/stream',
  //         loading: (context) {
  //           // Change the color of the loading indicator here
  //           return const Center(
  //             child: CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(
  //                   Colors.white), // Change the color here
  //             ),
  //           );
  //         },
  //         error: (context, error, stackTrace) {
  //           // Handle error condition here
  //           return SvgPicture.asset(
  //             'assets/error.svg', // Replace with your SVG image
  //             width: MediaQuery.of(context).size.width * 0.25,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildConnectivityIndicator() {
  //   return const Icon(
  //     Icons.wifi_off,
  //     color: Colors.white,
  //     size: 48.0,
  //   );
  // }

  // Widget _buildVRButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         isVRMode = !isVRMode;
  //       });
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: isVRMode ? Colors.white : Colors.black,
  //         borderRadius: BorderRadius.circular(20.0),
  //         border: Border.all(
  //           color: isVRMode ? Colors.black : Colors.white,
  //           width: 2.0,
  //         ),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       child: Text(
  //         isVRMode ? 'VR OFF' : 'VR ON',
  //         style: TextStyle(
  //           color: isVRMode ? Colors.black : Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildButton(IconData icon,command) {
     bool holdingButton = false;

      Future<void> _sendCommand(String command) async {
    try {
      final response = await http.get(
        Uri.parse('http://${widget.ipAddres+command}'),
      );

      if (response.statusCode == 200) {
        print('Command sent successfully: $command');
      } else {
        print('Failed to send command: http://${widget.ipAddres+command}');
      }
    } catch (error) {
      print('Error sending command: $error');
    }
      }
      Future<void> _delayedStop() async {
    await Future.delayed(Duration(milliseconds:200 ));
    await _sendCommand('/stop');
  }
    
    void _startCommand(String command) {
    _sendCommand(command);
    holdingButton = true;
  }

  void _stopCommand() {
    if (holdingButton) {
      _sendCommand('/stop');
      holdingButton = false;
    }
  }

    return GestureDetector(
     onTapDown: (_) => _startCommand(command),
              onTapUp: (_) => _stopCommand(),
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
