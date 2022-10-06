import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final keepProvider =
    StateNotifierProvider<KeepState, Counter>((ref) => KeepState());

class KeepState extends StateNotifier<Counter> {
  KeepState() : super(const Counter());
  void countUp() {
    state = Counter(count: state.count + 1);
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
    final counter = useState(0);

    Future _loadCounter() async {
      final prefs = await SharedPreferences.getInstance();

      counter.value = (prefs.getInt('counter') ?? 0);
    }

    Future _incrementCounter() async {
      final prefs = await SharedPreferences.getInstance();

      counter.value = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', counter.value);
    }

    Future _deleteCounter() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.remove('counter');
      _loadCounter();
    }

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
