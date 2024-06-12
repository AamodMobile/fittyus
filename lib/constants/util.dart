import 'constants.dart';

successToast(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar(
    duration: const Duration(seconds: 2),
    '',
    msg,
    titleText: const SizedBox.shrink(),
    snackPosition: SnackPosition.TOP,
    backgroundColor: greenColor,
    colorText: Colors.black,
    margin: const EdgeInsets.all(10),
  );
}

errorToast(String msg) {
  Get.closeAllSnackbars();
  Get.snackbar(
    duration: const Duration(seconds: 2),
    '',
    msg,
    titleText: const SizedBox.shrink(),
    snackPosition: SnackPosition.TOP,
    backgroundColor: redColor,
    colorText: Colors.white,
    margin: const EdgeInsets.all(10),
  );
}

showProgress() {
  Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child:
            const Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      barrierDismissible: false);
}

closeProgress() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
