import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Timers',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fancy Timers'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerButton(title: '00:10', duration: Duration(seconds: 10)),
            TimerButton(title: '1 minute', duration: Duration(minutes: 1)),
            TimerButton(title: '3 minutes', duration: Duration(minutes: 3)),
            TimerButton(title: '5 minutes', duration: Duration(minutes: 5)),
            // Add more TimerButton instances as needed
          ],
        ),
      ),
    );
  }
}

class TimerButton extends StatefulWidget {
  final String title;
  final Duration duration;

  const TimerButton({super.key, required this.title, required this.duration});

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  int countdownValue = 10;
  bool isCountingDown = false;

  AudioPlayer audioPlayer = AudioPlayer();

  void startCountdown() {
    setState(() {
      isCountingDown = true;
    });

    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (countdownValue == 0) {
        timer.cancel();
        countdownValue = 10;
        setState(() {
          isCountingDown = false;
        });
      } else {
        setState(() {
          countdownValue--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // TODO
  void _onTimerEnd() async {
    // Play alarm sound
    await audioPlayer.play(AssetSource('sounds/alarm.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isCountingDown ? null : startCountdown,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(isCountingDown ? '$countdownValue s' : widget.title),
    );
  }
}
