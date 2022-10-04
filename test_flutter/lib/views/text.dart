import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextView extends HookConsumerWidget {
  const TextView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updator = useState(0);

    Widget nameContent() {
      return Column(children: [
        Padding(padding: EdgeInsets.only(top: 23)),
        Text('入力テスト',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        Padding(padding: EdgeInsets.only(bottom: 9)),
        CupertinoTextField(
            // enabled: isMyProfileSetting,
            onChanged: (_) {
              updator.value += 1;
            },
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            // controller: profileContentTitleList.value['ニックネーム'],
            placeholder: '',
            textAlign: TextAlign.center),
      ]);
    }

    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final scrollController = ScrollController();
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      return null;
    }, const []);

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
            height: MediaQuery.of(context).size.height - 60,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(children: [
                  SingleChildScrollView(
                      controller: scrollController,
                      physics: ClampingScrollPhysics(),
                      reverse: true,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: bottomSpace),
                          child: Stack(children: [
                            // imagesContent(),
                            Container(
                                margin: EdgeInsets.only(top: 118),
                                child: Column(children: [
                                  nameContent(),
                                  div(),
                                  Padding(padding: EdgeInsets.only(bottom: 67))
                                ])),
                          ]))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: bottomSpace),
                          child: Container(
                              height: 47,
                              width: 297,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 14)
                                  ]),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('戻る',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black))),
                                    // ...[
                                    //   Padding(
                                    //       padding: EdgeInsets.only(right: 80)),
                                    //   GestureDetector(
                                    //       onTap: saveTriger.value
                                    //           ? () async {
                                    //               // showIndicator(context);
                                    //               // await submit();
                                    //               Navigator.pop(context);
                                    //               Navigator.pop(context);
                                    //             }
                                    //           : null,
                                    //       child: Text('登録',
                                    //           style: TextStyle(
                                    //               fontSize: 18,
                                    //               color: saveTriger.value
                                    //                   ? Colors.black
                                    //                   : Color(0xFFC0C0C0))))
                                    // ]
                                  ]))))
                ]))));
  }

  Widget div() {
    return Divider(height: 40, thickness: 1, color: const Color(0xFFEEEEEE));
  }

  Widget rowContent(String title, Widget content) {
    return Column(children: [
      div(),
      Padding(
          padding: EdgeInsets.only(left: 19, right: 25),
          child: IntrinsicHeight(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                alignment: Alignment.topLeft,
                width: 136 - 19,
                child: Text(title)),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: content,
            ))
          ])))
    ]);
  }
}
