import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FontView extends HookConsumerWidget {
  FontView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // フォントサイズ
              Text(
                'Hello World!',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 32),
              ),
              // ボールド体(太字)
              Text(
                'Hello World!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // 更に太字・更に細字 FontWeight.w100 から FontWeight.w900 まで ９段階
              Text(
                'Hello World!',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Text(
                'Hello World!',
                style: TextStyle(fontWeight: FontWeight.w100),
              ),
              // イタリック体
              Text(
                'Hello World!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              // 下線
              Text(
                'Hello World!',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              // 破線・細かい破線
              Text(
                'Hello World!',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              Text(
                'Hello World!',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted),
              ),
              // 二重下線
              Text(
                'Hello World!',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double),
              ),
              // 波線
              Text(
                'Hello World!',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              // 取り消し線
              Text(
                'Hello World!',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              // テキスト色
              Text(
                'Hello World!',
                style: TextStyle(color: Colors.red),
              ),
              // 背景色
              Text('Hello World!',
                  style: TextStyle(backgroundColor: Colors.yellow)),
              // 上線
              Text(
                'Hello World!',
                style: TextStyle(decoration: TextDecoration.overline),
              ),
              // 文字間隔
              Text(
                'Hello World!',
                style: TextStyle(letterSpacing: 4.0),
              ),
              // 単語間隔
              Text(
                'Hello World!',
                style: TextStyle(wordSpacing: 8.0),
              ),
              // 影 (配列型のShadow Widgetは複数使用可能) (offset は影の相対位置) (blurRadius は影のぼかし)
              Text('Hello World!',
                  style: TextStyle(shadows: <Shadow>[
                    Shadow(
                        offset: Offset(5.0, 10.0),
                        blurRadius: 2.0,
                        color: Colors.black)
                  ])),
            ]),
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
