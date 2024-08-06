import 'package:fittyus/constants/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _documentLoadFailed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: PreferredSize(
          preferredSize:
              Size(Dimensions.height90, MediaQuery.of(context).size.width),
          child: Container(
            height: Dimensions.height45 + Dimensions.height20,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 15,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                ),
              ],
            ),
            child: Row(
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
              ],
            ),
          ),
        ),
        body: _documentLoadFailed
            ? Center(
                child: Text(
                  "No data found",
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: bold,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: Dimensions.font14),
                ),
              )
            : SfPdfViewer.network(
                widget.url,
                onDocumentLoadFailed: (error) {
                  setState(() {
                    _documentLoadFailed = true;
                  });
                },
                pageSpacing: 0,
              ),
      ),
    );
  }
}
