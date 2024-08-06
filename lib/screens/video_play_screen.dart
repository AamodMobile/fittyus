import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/widgets/video_item.dart';

class VideoPlayScreen extends StatefulWidget {
  final String file;
  final int id;

  const VideoPlayScreen({super.key, required this.file, required this.id});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Row(
            children: [
              SizedBox(
                width: 30,
                height: 40,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "Video",
                style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayerItem(
                videoUrl: widget.file,
                isPaused: false,
                videoId: widget.id,
              ),
            )
          ],
        ),
      ),
    );
  }
}
