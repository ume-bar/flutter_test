import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final keepProvider =
    StateNotifierProvider<KeepState, Counter>((ref) => KeepState());

class KeepState extends StateNotifier<Counter> {
  KeepState() : super(const Counter());

  Future loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(countPrefsKey) ?? 0);
    return count;
  }

  Future incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();

    final count = (prefs.getInt(countPrefsKey) ?? 0) + 1;
    prefs.setInt(countPrefsKey, count);
  }

  void deleteCounter() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(countPrefsKey);
    loadCounter();
  }

  void countUp() {
    state = Counter(count: state.count + 1);
    incrementCounter();
  }
}

// SharedPreferences で使用する記憶用のキー
const countPrefsKey = 'counter';

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
            ElevatedButton(
              onPressed: provider.deleteCounter,
              child: const Text('Reset Counter'),
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
