import 'package:fittyus/screens/dashboard_screenn.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/controller/video_animation_list_controller.dart';

class PlayYoutubeVideo extends StatefulWidget {
  final String id;
  final String url;
  final String title;
  final String lastTime;

  const PlayYoutubeVideo({super.key, required this.url, required this.title, required this.id, required this.lastTime});

  @override
  State<PlayYoutubeVideo> createState() => _PlayYoutubeVideoState();
}

class _PlayYoutubeVideoState extends State<PlayYoutubeVideo> {
  late YoutubePlayerController _controller;
  VideoAnimationListController videoAnimationListController = Get.put(VideoAnimationListController());
  int watchTime = 0;

  @override
  void initState() {
    String youtubeUrl = widget.url;
    String? videoId = extractVideoId(youtubeUrl);
    int startAtTimeInSeconds = int.parse(widget.lastTime);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? extractVideoId("https://www.youtube.com/watch?v=ywgf1dtN3WU")!,
      flags: YoutubePlayerFlags(
        startAt: startAtTimeInSeconds,
        autoPlay: true,
        mute: false,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        Get.back();
        successToast("Video Completed!");
        watchTime = _controller.value.position.inSeconds.toInt();
        videoAnimationListController.videoProgressUpdateApi(widget.id, watchTime.toString(), false);
      }
    });

    super.initState();
  }

  String? extractVideoId(String url) {
    RegExp regExp = RegExp(r'(?<=watch\?v=|/videos/|embed\/|youtu.be\/|youtu.be\/|watch\?v%3D|watch\?feature=player_embedded&v=|%2Fvideos%2F|youtu.be%2F|%2Fyoutu.be%2F)[^&?=%#]*');
    RegExpMatch? match = regExp.firstMatch(url);
    return match?.group(0);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.value.isPlaying) {
          _controller.pause();
          watchTime = _controller.value.position.inSeconds.toInt();
          videoAnimationListController.videoProgressUpdateApi(widget.id, watchTime.toString(), false);
        }
        Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Image.asset(
                appNewLogo,
                height: 90,
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Are you sure want to video exit ?",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                fixedSize: const Size(100, 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Get.back();
                _controller.play();
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
              },
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 15),
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () async {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Get.to(() => const DashBoardScreen(index: 2));
              },
            )
          ],
          barrierDismissible: true,
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
              onEnded: (_) {
                _controller.pause();
              },
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
              ],
            ),
            builder: (context, player) => player,
          ),
        ),
      ),
    );
  }
}
