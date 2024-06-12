import 'package:fittyus/constants/constants.dart';
import 'package:video_player/video_player.dart';
bool shouldAutoPlayReel = true;
class VideoController extends GetxController {
  VideoPlayerController? videoPlayerController;
  final RxBool isLoading = true.obs;
  final RxBool videoInitialized = false.obs; // Rename the property
  final RxBool isBuffering = false.obs;
  final RxString errorText = RxString('');

  Future<void> initializeVideo(String videoUrl) async {
    try {
      videoPlayerController = VideoPlayerController.network(videoUrl);
      await videoPlayerController!.initialize();

      isLoading.value = false;
      videoInitialized.value = true;
      if (shouldAutoPlayReel) {
        videoPlayerController!.play();
      }

      videoPlayerController!.setLooping(true);
      videoPlayerController!.setVolume(1);
      videoPlayerController!.addListener(() {
        if (videoPlayerController!.value.isBuffering) {
          isBuffering.value = true;
        } else {
          isBuffering.value = false;
        }
      });
    } catch (error) {
      errorText.value = "Video Can't Play";
      Get.back();
      errorToast(errorText.value);

    }
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}