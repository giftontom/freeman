// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freeman/src/Screens/cam_view.dart';
import 'package:freeman/src/Screens/vr_view.dart';
import 'package:freeman/src/router_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

 class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playAudio();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _playAudio() async {
    // Provide the path to your MP3 file in the assets
    String audioPath = "assets/sound.mp3";

    // Load and play the audio file in a loop
    await _audioPlayer.setAsset(audioPath);
    _audioPlayer.setLoopMode(LoopMode.one); // Set loop mode
    _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Stop audio on dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Pause audio when app is paused (minimized)
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      // Resume audio when app is resumed
      _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * .5,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/wp.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .3,
                                  height: MediaQuery.of(context).size.width *
                                      .05241,
                                  margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * .0533,
                                  ),
                                  child: Image.asset(
                                    "assets/gardro.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height:
                                MediaQuery.of(context).size.width * .0705241,
                            margin: EdgeInsets.all(
                              MediaQuery.of(context).size.height * .0833,
                            ),
                            child: Image.asset(
                              "assets/gardroTagline.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * .08,
                        ),
                        child: GameIdInput(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuggestionTextField extends StatefulWidget {
  @override
  _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  TextEditingController _controller = TextEditingController();
  List<String> previousTexts = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadTextSuggestions();
  }

  void _loadTextSuggestions() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      previousTexts = _prefs.getStringList('textSuggestions') ?? [];
    });
  }

  void _saveTextSuggestion(String text) {
    setState(() {
      previousTexts.insert(0, text);
    });
    _prefs.setStringList('textSuggestions', previousTexts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Enter Text'),
          onChanged: (text) {
            _saveTextSuggestion(text);
          },
        ),
        SizedBox(height: 10),
        Text('Previous Texts:'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: previousTexts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(previousTexts[index]),
            );
          },
        ),
      ],
    );
  }
}

class GameIdInput extends StatefulWidget {
  @override
  _GameIdInputState createState() => _GameIdInputState();
}

class _GameIdInputState extends State<GameIdInput> {
  TextEditingController _urlController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadLastEnteredText();
  }

  void _loadLastEnteredText() async {
    _prefs = await SharedPreferences.getInstance();
    String? lastText = _prefs.getString('lastEnteredText');
    if (lastText != null) {
      setState(() {
        _urlController.text = lastText;
      });
    }
  }

  void _saveLastEnteredText(String text) {
    _prefs.setString('lastEnteredText', text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _urlController,
          onChanged: (text) {
            _saveLastEnteredText(text);
          },
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: 'Enter IP Address',
            hintText: 'eg: 193.38.18',
            filled: true,
            
            labelStyle: const TextStyle(
              color: Color.fromRGBO(200, 198, 188, 1),
            ),
            helperStyle: const TextStyle(
              color: Color.fromRGBO(200, 198, 188, 1),
            ),
            hintStyle: const TextStyle(
              color: Color.fromRGBO(200, 198, 188, 1),
            ),
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(
              Icons.videogame_asset,
              color: Color.fromRGBO(200, 198, 188, 1),
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color.fromRGBO(200, 198, 188, 1),
              ),
              onPressed: () {
                _urlController.clear();
              },
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(25.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          style: TextStyle(
            color: Color.fromRGBO(200, 198, 188, 1),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .04266,
        ),
        ElevatedButton(
          onPressed: () {
        if(_urlController.text!="")   {   Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MonitoringPage(
                    ipAddres: _urlController.text,
                  ), // Replace with your home screen widget
                ) ,
              );}
            
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[900],
            onPrimary: Color.fromRGBO(200, 198, 188, 1),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.height * .032,
            ),
            child: Text(
              'Connect',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
