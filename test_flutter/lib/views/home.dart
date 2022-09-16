import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends HookConsumerWidget {
  HomeView({Key? key}) : super(key: key);
  final Stopwatch timer = Stopwatch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerDisplay = useState('00:00:00.000');
    const dul = Duration(milliseconds: 10);
    final isStopPressed = useState(true);
    final isResetPressed = useState(true);
    final isStartPressed = useState(true);

    void keepRunning() {
      if (timer.isRunning) {
        Timer(dul, keepRunning);
      }
      int milliSeconds = ((timer.elapsedMilliseconds / 10).floor() % 100);
      // ignore: prefer_interpolation_to_compose_strings
      timerDisplay.value = (timer.elapsed.inHours).toString().padLeft(2, '0') +
          ':' +
          (timer.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          ':' +
          (timer.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
          ':' +
          (milliSeconds).toString().padLeft(3, '0');
    }

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text(
            timerDisplay.value,
            style: Theme.of(context).textTheme.headline2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    isStopPressed.value = false;
                    isStartPressed.value = false;
                    isResetPressed.value = false;
                    timer.start();
                    Timer(dul, keepRunning);
                  },
                  child: const Text('スタート')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    isStopPressed.value = true;
                    isResetPressed.value = false;
                    isStartPressed.value = true;
                    timer.stop();
                  },
                  child: const Text('ストップ')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    isResetPressed.value = true;
                    isStartPressed.value = true;
                    isStopPressed.value = true;
                    timer.stop();
                    timer.reset();
                    timerDisplay.value = '00:00:00.000';
                  },
                  child: const Text('リセット')),
            ],
          ),
        ],
      ),
    ));
  }
}
