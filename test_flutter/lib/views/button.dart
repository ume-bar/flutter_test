import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonView extends HookConsumerWidget {
  const ButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 1
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 2
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 3
                OutlinedButton(
                  child: const Text('Button'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.blueAccent),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 4
                OutlinedButton(
                  child: const Text('Button'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Colors.blueAccent),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 5
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 6
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.star_outline,
                    color: Colors.blueAccent,
                  ),
                  label: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            // 2列目
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 7
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 8
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 9
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(24)),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Button'),
                ),
                SizedBox(
                  width: 5,
                ),
                // 10
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Button"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                ),
                SizedBox(
                  width: 5,
                ),
                // 11
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Button"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.elliptical(10, 40)
                              //  bottomLeft:, bottom left
                              // bottomRight: bottom right
                              ))),
                ),
                // 12
                ElevatedButton(
                  child: const Text('Btn'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            // 3列目
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 13
                TextButton(
                  child: const Text('Button'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 14
                // TextButton(
                //   style: ButtonStyle(
                //     foregroundColor: MaterialStateProperty.all<Color>(
                //         Colors.lightBlueAccent),
                //   ),
                //   onPressed: () {},
                //   child: Text('Button'),
                // ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightBlueAccent),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Button'),
                ),
                //
                // TextButton(
                //   style: ButtonStyle(
                //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
                //         (Set<MaterialState> states) {
                //       if (states.contains(MaterialState.focused))
                //         return Colors.red;
                //       return null; // Defer to the widget's default.
                //     }),
                //   ),
                //   onPressed: () {},
                //   child: Text('Button'),
                // ),

                SizedBox(
                  width: 5,
                ),
                // 15
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightBlueAccent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Button',
                    style: TextStyle(
                        fontSize: 20, decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // 16
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(width: 2, color: Colors.lightBlueAccent),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Button',
                    style: TextStyle(
                        fontSize: 16, decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // 17
                ElevatedButton(
                  child: const Text('Button'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    elevation: 16,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
                // 18
                ElevatedButton(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.lightBlueAccent,
                          Colors.blue,
                          Colors.blueAccent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Text('Button'),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
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
