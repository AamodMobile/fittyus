import 'package:fittyus/constants/constants.dart';

class SliderController extends GetxController implements GetxService {
  var currentPage = 0.obs;
  final totalPages = 3.obs;

  var images = [slideOne, slideTwo, slideThree].obs;
}
