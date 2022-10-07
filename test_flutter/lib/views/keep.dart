import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final keepProvider =
    StateNotifierProvider<KeepState, Counter>((ref) => KeepState());

class KeepState extends StateNotifier<Counter> {
  KeepState() : super(const Counter());

  void countUp() async {
    // Shared preferencesのインスタンスを非同期で取得しprefsに入れる。
    final prefs = await SharedPreferences.getInstance();
    // Counterクラスのcountに取得したデータを入れる　初期時はnull
    state = Counter(count: (prefs.getInt(countPrefsKey) ?? 0) + 1);
    // setIntで(キーの,内容を)保存
    prefs.setInt(countPrefsKey, state.count);
  }
}

// SharedPreferences で使用する記憶用のキー
const countPrefsKey = 'counter';

// カウンタークラス　初期時は0
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
    // providerで取得してきたCounterのcountを初期値として設定
    final counter = useState(state.count);

    // シュミレーターをリセットかけても読み込むようにするメソッド
    Future loadCounter() async {
      final prefs = await SharedPreferences.getInstance();
      final loadCounter = Counter(count: prefs.getInt(countPrefsKey) ?? 0);
      return counter.value = loadCounter.count;
    }

    // シュミレーターのデバイスにセーブしてあるデータを消去
    Future deleteCounter() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(countPrefsKey);
      loadCounter();
    }

    // 状態管理で常に保存状況を読み込む
    useEffect(() {
      Future.microtask(() async {
        await loadCounter();
      });
      return;
    });

    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: deleteCounter,
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
