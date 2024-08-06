import 'package:fittyus/constants/constants.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController? reelsPlayerController;
bool shouldAutoPlayReel = true;

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool isPaused;
  final int videoId;
  final VoidCallback? callback;

  const VideoPlayerItem({super.key, required this.videoUrl,
    required this.isPaused,
    required this.videoId,
    this.callback});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _videoPlayerController;
  bool isLoading = true;
  bool initialized = false;
  bool isBuffering = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(Uri.parse(widget.videoUrl).toString());
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      await _videoPlayerController!.initialize();

      if (mounted) {
        setState(() {
          isLoading = false;
          initialized = true;
        });

        // Play the video if shouldAutoPlayReel is true
        if (shouldAutoPlayReel) {
          _videoPlayerController!.play();
        }

        _videoPlayerController!.setLooping(true);
        _videoPlayerController!.setVolume(1);

        // Add a listener to handle buffering
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.isBuffering) {
            if (mounted) {
              setState(() {
                isBuffering = true;
              });
            }
          } else {
            if (mounted && isBuffering) {
              setState(() {
                isBuffering = false;
              });
            }
          }
        });
      }
    } catch (error) {
      Get.back();
      errorToast("Video Can't Play ");

    }
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (errorText != null)
            Center(
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          else if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: whiteColor,
              ),
            )
          else
            SizedBox(
              width: Dimensions.screenWidth,
              height: Dimensions.screenHeight,
              child: VideoPlayer(_videoPlayerController!),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _videoPlayerController!.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: () {
                  if (_videoPlayerController!.value.isPlaying) {
                    _videoPlayerController!.pause();
                  } else {
                    _videoPlayerController!.play();
                  }
                  setState(() {});
                },
              ),
            ],
          ),
          Visibility(
            visible: isBuffering,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const WidgetSpan(child: CircularProgressIndicator()),
                    TextSpan(
                      text: '\n\nLoading',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: Dimensions.font14,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            color: Colors.white,
                            offset: Offset(0, 0),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

