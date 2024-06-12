import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/screens/search_screen.dart';

class SearchNewScreen extends StatefulWidget {
  const SearchNewScreen({super.key});

  @override
  State<SearchNewScreen> createState() => _SearchNewScreenState();
}

class _SearchNewScreenState extends State<SearchNewScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bgCommunityItems,
      appBar: PreferredSize(
        preferredSize: Size(Dimensions.height90, MediaQuery.of(context).size.width),
        child: Container(
          height: Dimensions.height45 + Dimensions.height20,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(color: whiteColor, boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 15, spreadRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.2))]),
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
              const SizedBox(
                width: 12,
              ),
              Text(
                "Search",
                style: TextStyle(color: mainColor, fontFamily: semiBold, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: Dimensions.font16),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFC3BBBB))),
              child: const Center(
                child: Text(
                  "Select below category for searching",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: medium,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 33,
              width: MediaQuery.of(context).size.width,
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                    Get.to(() => const SearchScreen(type: 'All'));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 1 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 1 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          allSearchIc,
                          width: 56,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "All",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(width: 40),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                    Get.to(() => const SearchScreen(type: 'Customer Profile'));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 2 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 2 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          custmoreProfile,
                          width: 56,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "Customer Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                    Get.to(() => const SearchScreen(type: 'Category'));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 3 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 3 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          categorySerch,
                          width: 56,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "Category",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(width: 40),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 4;
                    });
                    Get.to(() => const SearchScreen(
                          type: 'Session',
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 4 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 4 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          sessionSearch,
                          width: 80,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "Session",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 5;
                    });
                    Get.to(() => const SearchScreen(
                          type: 'Coach',
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 5 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 5 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          coachSearch,
                          width: 56,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "Coach",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(width: 40),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = 6;
                    });
                    Get.to(() => const SearchScreen(
                          type: 'Challenge',
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), border: Border.all(color: selectedIndex == 6 ? const Color(0xFF15B3B3) : const Color(0xFFC3BBBB), width: selectedIndex == 6 ? 4 : 1)),
                    child: Column(
                      children: [
                        const SizedBox(height: 7),
                        Image.asset(
                          challengeSearch,
                          width: 56,
                          height: 62,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Center(
                          child: Text(
                            "Challenge",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ));
  }
}
