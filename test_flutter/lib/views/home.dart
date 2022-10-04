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
      backgroundColor: Colors.white70,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // 数字, アルファベットのベースライン
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
                height: 160.0,
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HH : MM : SS . fff ",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        timerDisplay.value,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(),
                            ),
                            onPressed: () async {
                              isStopPressed.value = false;
                              isStartPressed.value = false;
                              isResetPressed.value = false;
                              timer.start();
                              Timer(dul, keepRunning);
                            },
                            child: const Text('スタート'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(),
                              ),
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
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(),
                              ),
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
                      )
                    ]))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        // ヒントを表示
        tooltip: 'return',
        child: const Icon(Icons.replay_outlined),
      ),
    );
  }
}
