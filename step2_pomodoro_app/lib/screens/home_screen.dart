import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  static const twentyFiveMinutes = 5;
  int totalSeconds = twentyFiveMinutes;
  int totalPomodoros = 0;
  bool isRunning = false;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds--;
      if (totalSeconds == 0) {
        totalSeconds = twentyFiveMinutes;
        totalPomodoros++;
        isRunning = false;
        timer.cancel();
      }
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2);
  }

  void initTimer() {
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                // '$totalSeconds',
                //'${totalSeconds ~/ 60} : ${(totalSeconds % 60).toString().padLeft(2, '0')}',
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                    ),
                  ),
                  InkWell(
                    // 핸드폰 이벤트들을 다 넣을 수 있는 곳,, 영역 클릭을 위해서,,,
                    onTap: initTimer,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh_outlined,
                            color: Theme.of(context).cardColor,
                          ),
                          Text(
                            'refresh',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                              fontSize: 58,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
