import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonView extends HookConsumerWidget {
  const ButtonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
