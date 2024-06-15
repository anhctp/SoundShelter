import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/notification/my_alert.dart';

class TimerPicker extends StatefulWidget {
  final dynamic value;
  const TimerPicker({super.key, required this.value});

  @override
  State<TimerPicker> createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tắt nhạc sau',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 10),
                //10ph
                InkWell(
                  onTap: () {
                    widget.value.onSelectedTime(10 * 60);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(content: 'Dừng phát sau 10 phút');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      '10 Phút',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //15ph
                InkWell(
                  onTap: () {
                    widget.value.onSelectedTime(15 * 60);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(content: 'Dừng phát sau 15 phút');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      '15 Phút',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //30ph
                InkWell(
                  onTap: () {
                    widget.value.onSelectedTime(30 * 60);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(content: 'Dừng phát sau 30 phút');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      '30 Phút',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //1h
                InkWell(
                  onTap: () {
                    widget.value.onSelectedTime(60 * 60);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return MyAlert(content: 'Dừng phát sau 1 giờ');
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      '1 Giờ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //set yourself
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Duration selectedTime =
                        Duration(hours: 0, minutes: 0, seconds: 0);
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Tùy chọn khác',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            const SizedBox(height: 10),
                            CupertinoTheme(
                              data: CupertinoThemeData(
                                textTheme: CupertinoTextThemeData(
                                  dateTimePickerTextStyle:
                                      TextStyle(color: Colors.black),
                                ),
                              ),
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hms,
                                minuteInterval: 1,
                                secondInterval: 1,
                                initialTimerDuration: selectedTime,
                                onTimerDurationChanged:
                                    (Duration changedTimer) {
                                  selectedTime = changedTimer;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.red.shade100)),
                                  child: Text(
                                    'Hủy',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.value.onSelectedTime(
                                          selectedTime.inSeconds);
                                    });
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return MyAlert(
                                              content:
                                                  'Dừng phát sau ${selectedTime.inHours} giờ ${selectedTime.inMinutes} phút ${selectedTime.inSeconds} giây');
                                        });
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.lightGreen.shade300)),
                                  child: Text(
                                    'Lưu',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                    width: double.infinity,
                    child: Text(
                      'Tùy chọn khác',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
      icon: const Icon(Icons.timer_outlined),
    );
  }
}
