
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../resorces/pallete.dart';

class DateSelector extends StatefulWidget {
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime(2025, 7, 16);

  // ایجاد 7 روز اطراف تاریخ انتخاب‌شده
  List<DateTime> get dates {
    return List.generate(7, (index) {
      return selectedDate.subtract(Duration(days: 3 - index));
    });
  }

  void changeDay(int direction) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: direction));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //-----------------------------------------------------------------------
        //    🔵 Title Row with Arrows (Thursday July 16)
        //-----------------------------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => changeDay(-1),
              child: Icon(Icons.arrow_left,
                  size: 32, color: Colors.purple[800]),
            ),
            SizedBox(width: 10),
            Text(
              "${DateFormat('EEEE').format(selectedDate)}  ${DateFormat('MMMM d').format(selectedDate)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.purple[800],
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () => changeDay(1),
              child: Icon(Icons.arrow_right,
                  size: 32, color: Colors.purple[800]),
            ),
          ],
        ),

        SizedBox(height: 10),

        //-----------------------------------------------------------------------
        //                          🔥 Date Picker List
        //-----------------------------------------------------------------------
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dates.length,
            itemBuilder: (context, index) {
              DateTime date = dates[index];
              bool isSelected = date.day == selectedDate.day;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                },
                child: Container(
                  width: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Palette.bgMood,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   Image.asset('assets/images/sad.png'),
                      SizedBox(height: 5),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Palette.textForeground : Palette.textMutedForeground,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('E').format(date),
                        style: TextStyle(
                          color: isSelected ? Palette.textForeground : Palette.textMutedForeground,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
