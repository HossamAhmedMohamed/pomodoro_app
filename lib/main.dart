// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterDownApp(),
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({Key? key}) : super(key: key);

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (qqqqqq) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pomodoro App",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 50, 65, 71),
      ),
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                progressColor: Color.fromARGB(255, 255, 85, 113),
                 backgroundColor: Color.fromARGB(255, 255, 255, 255),
                 lineWidth: 7,
                percent: duration.inMinutes / 25,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                radius: 120.0,
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: TextStyle(fontSize: 77, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 55,
          ),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      child: Text(
                        (repeatedFunction!.isActive) ? "Stop" : "Resume",
                        style: TextStyle(fontSize: 22,
                        color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          duration = Duration(minutes: 25);
                          isRunning = false;
                        });
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 19,
                        color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text(
                    "Start Studying",

                    style: TextStyle(fontSize: 23,
                    color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 25, 120, 197)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                )
        ],
      ),
    );
  }
}
