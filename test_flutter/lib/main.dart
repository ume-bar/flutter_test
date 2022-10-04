import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/states/kintone_api.dart';
import 'package:test_flutter/views/home.dart';
import 'dart:convert' as convert;

Future<void> main() async {
  // メッセージの翻訳、日本のロケールにする。
  Intl.defaultLocale = 'ja';
  // runApp()を呼び出す前に初期化する必要があり、WidgetsBindingのインスタンスを必要に応じてリターン。
  WidgetsFlutterBinding.ensureInitialized();
  // アプリケーションの実行中に表示される、ステータスバーやナビゲーションバーの設定（没入モード）
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //　起動時に読み込むenvファイルを指定
  await dotenv.load(fileName: ".env");
  // runAppの後にProviderScopeを置かないとriverpodのエラーが出る。
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// provider イミュータブル（インタフェースを介さない限り、一度構築した構成を変更せず固定化）で複雑なステートオブジェクト
final homeProvider =
    StateNotifierProvider<HomeState, Counter>((ref) => HomeState());

// state class StateNotifierが完全にイミュータブル化
class HomeState extends StateNotifier<Counter> {
  HomeState() : super(const Counter());
  // ここの関数はprovider.の方から変更可能。
  void increment() {
    state = Counter(count: state.count + 1);
    // getAPI
    fetchRecords('');
    // postAPI
    postRecord(state.count);
  }
}

// state data 作成後は状態を変えることはできないオブジェクト。
@immutable
class Counter {
  const Counter({this.count = 0});
  final int count;
}

// 呼び出しがHookConsumerWidgetかConsumerWidgetを継承
class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  // useProviderがなくなり、WidgetRef(ref)を使用
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // プロバイダの値を取得し、その変化を監視。値が変化すると、その値に依存するウィジェットやプロバイダの更新。値を取得するのは、watchかlisten。
    final state = ref.watch(homeProvider);
    // プロバイダの値を取得（監視はしない）クリックイベント等の発生時に、その時点での値を取得する場合に使用。ステート自体を取得するのはread。
    final provider = ref.read((homeProvider.notifier));
    // プロバイダによりアプリの様々な場所からステートにアクセスできるようになる
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
            const SizedBox(height: 100.0),
            FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ),
                );
              },
              label: const Text('テスト画面へ移動'),
              icon: const Icon(Icons.touch_app),
              backgroundColor: Colors.pink,
            ),
            ElevatedButton(
              onPressed: provider.increment,
              child: const Icon(Icons.add),
            ),
            // FlutterVer2からRaisedButtonが非推奨になってstyleFromでラップして装飾する形になった。
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 16,
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 40,
                ),
              ),
              child: Text(
                'Text Form',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
