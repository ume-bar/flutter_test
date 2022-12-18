import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final primeProvider =
    StateNotifierProvider<PrimeState, Counter>((ref) => PrimeState());

class PrimeState extends StateNotifier<Counter> {
  PrimeState() : super(const Counter());
  void countUp() {
    state = Counter(count: state.count + 1);
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
