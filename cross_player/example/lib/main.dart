import 'package:cross_player/cross_player.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    title: 'Flutter Cross Player Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const Home(),
  ));
}

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Cross Player Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoPlayer(),));
            },child: Text("Video Player"),),
            SizedBox(height: 10,),
            FilledButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AudioPlayer(),));
            },child: Text("Audio Player"),)
          ],
        ),
      ),
    );
  }
}


class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});
  @override
  State<VideoPlayer> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VideoPlayer> {
  late PlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = PlayerController(
        media: const DataSource.network(
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
            mimeType: "audio/mp4"
        ),
        autoPlay: false,
        webOptions: {
          "customControlsOnMobile": true,
          "aspectRatio": "16:9",
          "controls": true,
          "liveui": true,
          "loop": true,
          "responsive": true,
          "fluid": true,
          "poster": "/assets/assets/cross_player/audio_bg.jpg",
        },
        audioView: false
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cross Video Player"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CrossPlayerWidget(
              controller: controller,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Network Source (Mp4)"),
                    onTap: () {
                      controller.setMedia(
                          const DataSource.network(
                            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                            mimeType: "video/mp4"
                          )
                      );
                    },
                    trailing: Icon(Icons.play_circle_fill),
                  ),
                  ListTile(
                    title: Text("Network Source (Mp4)"),
                    onTap: () {
                      controller.setMedia(
                          const DataSource.network(
                            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                            mimeType: "video/mp4"
                          )
                      );
                    },
                    trailing: Icon(Icons.play_circle_fill),
                  ),
                  ListTile(
                    title: Text("Live TvHeadend Tv"),
                    onTap: () {
                      controller.setMedia(DataSource.network(
                          "http://192.168.2.11:9981/stream/channel/856c9efe3902ffa612bdca92b4ce5587?profile=webtv-vp8-vorbis-webm",
                          mimeType: "video/webm")
                      );
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}


class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});
  @override
  State<AudioPlayer> createState() => _MyAudioPlayer();
}
class _MyAudioPlayer extends State<AudioPlayer> {
  late PlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = PlayerController(
        media: DataSource.network(
            "https://actions.google.com/sounds/v1/alarms/alarm_clock.ogg",
            mimeType: "audio/ogg"
        ),
        autoPlay: false,
        webOptions: {
          "customControlsOnMobile": true,
          "aspectRatio": "16:9",
          "controls": true,
          "liveui": true,
          "loop": true,
          "responsive": true,
          "fluid": true,
          "poster": "/assets/assets/cross_player/audio_bg.jpg",
        },
        audioView: true
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cross Audio Player"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CrossPlayerWidget(
              controller: controller,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Network Source (Mp3)"),
                    onTap: () {
                      controller.setMedia(
                          const DataSource.network(
                            "http://webaudioapi.com/samples/audio-tag/chrono.mp3",
                            mimeType: "audio/mp3"
                          )
                      );
                    },
                    trailing: Icon(Icons.play_circle_fill),
                  ),
                  ListTile(
                    title: Text("Live TvHeadend Radio"),
                    onTap: () {
                      controller.setMedia(DataSource.network(
                          "http://192.168.2.11:9981/stream/channel/28177b51ae1bf8d5083e4b13865c7870?profile=webtv-vp8-vorbis-webm",
                          mimeType: "video/webm")
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
