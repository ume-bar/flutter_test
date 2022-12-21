import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final primeProvider =
    StateNotifierProvider<PrimeState, Counter>((ref) => PrimeState());

class PrimeState extends StateNotifier<Counter> {
  PrimeState() : super(const Counter());

  Future<void> countUp() async {
    await for (int p in primeNumberStream()) {
      print(p);
      print(state.count);
      state = Counter(count: p);
    }
  }

  Future<void> stop() async {
    state = Counter(count: 0);
  }
}

Stream<int> primeNumberStream() async* {
  for (int i = 2;; i++) {
    bool isPrime = true;
    for (int j = 2; j <= i ~/ 2; j++) {
      if (i % j == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}

@immutable
class Counter {
  const Counter({this.count = 0});
  final int count;
}

class PrimeView extends HookConsumerWidget {
  const PrimeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(primeProvider);
    final provider = ref.read((primeProvider.notifier));

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${state.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: provider.stop,
                child: const Icon(Icons.stop),
              ),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.countUp,
        child: const Icon(Icons.add),
      ),
    );
  }
}
