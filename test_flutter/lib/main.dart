import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter/states/kintone_api.dart';
import 'package:test_flutter/views/button.dart';
import 'package:test_flutter/views/font.dart';
import 'package:test_flutter/views/home.dart';
import 'package:test_flutter/views/keep.dart';
import 'package:test_flutter/views/sample.dart';
import 'package:test_flutter/views/test.dart';
// import 'dart:convert' as convert;

import 'package:test_flutter/views/text.dart';
import 'package:test_flutter/views/timer.dart';

Future<void> main() async {
  // メッセージの翻訳、日本のロケールにする。
  Intl.defaultLocale = 'ja';
  // runApp()を呼び出す前に初期化する必要があり、WidgetsBindingのインスタンスを必要に応じてリターン。
  // WidgetsFlutterBinding.ensureInitialized();
  // デフォルトでは、Flutter が最初のフレームを描画すると、スプラッシュ スクリーンは削除される
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // アプリケーションの実行中に表示される、ステータスバーやナビゲーションバーの設定（没入モード）
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //　起動時に読み込むenvファイルを指定
  await dotenv.load(fileName: ".env");
  // runAppの後にProviderScopeを置かないとriverpodのエラーが出る。

  runApp(const ProviderScope(
    child: MyApp(),
  ));
  // アプリの初期化中にスプラッシュ スクリーンを残したい場合は、preserve()とremove()メソッドを使用する
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上のデバッグ帯を取る(false)
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

enum Menu { texts, containers, fonts }

List<String> menuList = [
  'Sample',
  'Home',
];

// 呼び出しがHookConsumerWidgetかConsumerWidgetを継承
class MyHomePage extends HookConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
            Text('緑のインクリメントボタンをタップした回数をKintoneに保存',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8)),
            Text(
              '${state.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 2.0),
            FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerView(),
                  ),
                );
              },
              label: const Text('ストップウォッチへ移動'),
              icon: const Icon(Icons.touch_app),
              backgroundColor: Colors.pink,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  onPressed: provider.increment,
                  child: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 2,
                ),
                // FlutterVer2からRaisedButtonが非推奨になってstyleFromでラップして装飾する形になった。
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewTextView(title: 'Flutter Demo Home Page')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 16,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20,
                    ),
                  ),
                  child: Text(
                    'Text Formへ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                ElevatedButton(
                  child: const Text('テスト画面へ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.deepOrange,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestView(
                                  title: 'Flutter Demo Home Page',
                                )));
                  },
                ),
                SizedBox(
                  width: 2,
                ),
                ElevatedButton(
                  child: const Text('Btn'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ButtonView()));
                  },
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('カウント保存→',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8)),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => KeepView()));
                },
                style: IconButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  disabledBackgroundColor: Colors.black,
                  hoverColor: Colors.grey,
                  focusColor: Colors.blueGrey,
                  highlightColor: Colors.white,
                ),
              ),
              // PopupMenuButton(
              //   onSelected: (value) {
              //     popupMenuSelected[value](context);
              //   },
              //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              //     const PopupMenuItem(
              //       value: 0,
              //       child: const ListTile(
              //           leading: Icon(Icons.supervisor_account),
              //           title: Text("Text")),
              //     ),
              //     const PopupMenuItem(
              //       child: const ListTile(
              //           leading: Icon(Icons.crop_original),
              //           title: Text("Home")),
              //       value: 1,
              //     ),
              Text('SELECT Page→',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 8)),
              PopupMenuButton<Menu>(
                onSelected: (value) {
                  popupMenuSelected(context, value);
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem(
                    value: Menu.texts,
                    child: const ListTile(
                        leading: Icon(Icons.text_fields), title: Text("Text")),
                  ),
                  const PopupMenuItem<Menu>(
                    child: const ListTile(
                        leading: Icon(Icons.home_filled), title: Text("Home")),
                    value: Menu.containers,
                  ),
                  const PopupMenuItem<Menu>(
                    child: const ListTile(
                        leading: Icon(Icons.font_download),
                        title: Text("Font")),
                    value: Menu.fonts,
                  ),
                ],
              ),
              DropdownButton<String>(
                value: menuList.first,
                items: menuList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) async {
                  if (value == 'Sample') {
                    await Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (_) => SampleView()));
                  } else if (value == 'Home') {
                    await Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (_) => HomeView()));
                  }
                },
              ),
            ])
          ],
        ),
      ),
    );
  }

  // PopupMenuButton専用メソッド
  void popupMenuSelected(BuildContext context, Menu selectedMenu) {
    switch (selectedMenu) {
      case Menu.texts:
        _pushPage(context, SampleView());
        break;
      case Menu.containers:
        _pushPage(context, HomeView());
        break;
      case Menu.fonts:
        _pushPage(context, FontView());
        break;
      default:
        break;
    }
  }

  void _pushPage(BuildContext context, Widget page) async {
    await Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => page));
  }

  // List<Function> popupMenuSelected = [
  //   (BuildContext context) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => SampleView()));
  //   },
  //   (BuildContext context) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomeView()));
  //   },
  // ];
}
