import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final keepProvider =
    StateNotifierProvider<KeepState, Counter>((ref) => KeepState());

class KeepState extends StateNotifier<Counter> {
  KeepState() : super(const Counter());
  void countUp() {
    state = Counter(count: state.count + 1);
  }
}

@immutable
class Counter {
  const Counter({this.count = 0});
  final int count;
}

class KeepView extends HookConsumerWidget {
  const KeepView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(keepProvider);
    final provider = ref.read((keepProvider.notifier));

    return Scaffold(
      appBar: AppBar(title: Text('')),
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
