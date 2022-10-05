import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/states/kintone_api.dart';

final testProvider =
    StateNotifierProvider<TestState, Counter>((ref) => TestState());

class TestState extends StateNotifier<Counter> {
  TestState() : super(const Counter());
  void countUp() {
    state = Counter(count: state.count + 1);
    fetchRecords('');
    postRecord(state.count);
  }
}

@immutable
class Counter {
  const Counter({this.count = 0});
  final int count;
}

class TestView extends HookConsumerWidget {
  const TestView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(testProvider);
    final provider = ref.read((testProvider.notifier));

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
