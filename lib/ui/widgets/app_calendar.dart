import 'package:clive/util/extensions/date.dart';
import 'package:clive/util/ui_util/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../util/ui_util/color_manager.dart';
import 'app_card.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({this.onDateChanged, super.key});
  final Function(DateTime date)? onDateChanged;

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> _currentMonthDates = [];

  List<DateTime> _getCurrentWeekDates() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));
    return List.generate(30, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void setDefaults() {
    _currentMonthDates = _getCurrentWeekDates();
    setState(() {
      selectedDate = _currentMonthDates.firstWhere((date)=> date.day == selectedDate.day);
    });
  }

  @override
  void initState() {
    setDefaults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(selectedDate.formatDateTime(format: 'MMM y',), style: AppTextStyles.black(weight: FontWeight.w700, size: 20),),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _currentMonthDates.length,
                  itemBuilder: (context, index) {
                    DateTime date = _currentMonthDates[index];
                    String dayName = DateFormat.EEEE().format(date);
                    String dayNumber = DateFormat.d().format(date);
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedDate = date;
                        });
                        widget.onDateChanged?.call(selectedDate);
                      },
                      splashFactory: NoSplash.splashFactory,
                      child: AppCard(
                        width: 56,
                        height: 46,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        borderWidth: selectedDate == _currentMonthDates[index] ? 2 : 1,
                        borderColor: selectedDate == _currentMonthDates[index] ? ColorManager.deepGreen : null,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Text(
                                dayName.substring(0, 3),
                                style: AppTextStyles.grey(size: 16),
                              ),
                            ),
                            Text(
                              dayNumber.length == 1
                                  ? '0$dayNumber'
                                  : dayNumber,
                              style: selectedDate == _currentMonthDates[index] ? AppTextStyles.deepGreen(weight: FontWeight.w600, size: 16) : AppTextStyles.black(size: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
