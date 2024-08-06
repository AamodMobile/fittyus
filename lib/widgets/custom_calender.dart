import 'package:fittyus/constants/constants.dart';
import 'package:fittyus/services/api_logs.dart';
import 'package:intl/intl.dart';

class DatePickerCustom extends StatefulWidget {
  final void Function(DateTime) onDateSelected;
  const DatePickerCustom({super.key, required this.onDateSelected});

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
  int selectedIndex = DateTime.now().day - 1;
  late DateTime now;
  late DateTime selectedDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedDate = DateTime.now();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  void _onDateSelected(int index) {
    DateTime selectedDate = DateTime(now.year, now.month, index + 1);
    var currentDateTime = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    DateTime oneDayAgo = currentDateTime.subtract(oneDay);
    Log.console('Selected: $selectedDate');
    if (selectedDate.isBefore(oneDayAgo)) {
    errorToast("Cannot select past dates.");
    }else{
    setState(() {
      selectedIndex = index;
      selectedDate = DateTime(now.year, now.month, index + 1);
    });
    _scrollController.jumpTo(index * 40.0);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    Log.console('Selected Date: $formattedDate');
    widget.onDateSelected(selectedDate); }
  }

  void _scrollToCurrentDate() {
    final currentDate = DateTime.now().day - 1;
    selectedIndex = currentDate;
    _scrollController.jumpTo(currentDate * 40.0);
  }

  @override
  Widget build(BuildContext context) {
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (now.month > DateTime.now().month) {
                      now = DateTime(now.year, now.month - 1, 1);
                      _scrollToCurrentDate();
                    } else {
                      errorToast("Last Month Not Allow");
                    }
                  });
                },
                icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.72,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: lastDayOfMonth.day,
                  itemBuilder: (context, index) {
                    final currentDate = lastDayOfMonth.add(Duration(days: index + 1));
                    final dayName = DateFormat('E').format(currentDate);
                    return InkWell(
                      onTap: () => _onDateSelected(index),
                      child: Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 5.0 : 0.0, right: 5.0),
                        child: Container(
                          height: 70,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: selectedIndex == index
                              ? BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                              )
                            ],
                          )
                              : null,
                          child: Column(
                            children: [
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: selectedIndex == index ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                dayName,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: selectedIndex == index ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                height: 4,
                                width: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex == index ? Colors.blue : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    now = DateTime(now.year, now.month + 1, 1);
                    _scrollToCurrentDate();
                  });
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
