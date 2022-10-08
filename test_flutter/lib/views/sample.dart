import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_flutter/views/home.dart';

// Listでもできますが、enumで拾えるようにしてあります。
enum Menu { PopupMenu, Dropdown, FloatingAction }

List<String> menuList = ['Sample', 'Home'];

class SampleView extends HookConsumerWidget {
  const SampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popup'),
        actions: <Widget>[
          PopupMenuButton<Menu>(
            onSelected: (value) {
              popupMenuSelected(context, value);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.PopupMenu,
                child: const ListTile(
                    leading: Icon(Icons.menu), title: Text("PopupMenuButton")),
              ),
              const PopupMenuItem<Menu>(
                child: const ListTile(
                    leading: Icon(Icons.arrow_drop_down),
                    title: Text("DropdownButton")),
                value: Menu.Dropdown,
              ),
              const PopupMenuItem<Menu>(
                child: const ListTile(
                    leading: Icon(Icons.add_circle_outline),
                    title: Text("FloatingActionButton")),
                value: Menu.FloatingAction,
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: DropdownButton<String>(
          value: menuList.first,
          items: menuList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) async {
            switch (menuList[0]) {
              case 'Sample':
                await Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => SampleView()));
                break;
              case 'Home':
                await Navigator.of(context)
                    .push(MaterialPageRoute<void>(builder: (_) => HomeView()));
            }
          },
        ),
      ),
    );
  }
}

void popupMenuSelected(BuildContext context, Menu selectedMenu) {
  switch (selectedMenu) {
    case Menu.PopupMenu:
      _pushPage(context, PopupMenuPage());
      break;
    case Menu.Dropdown:
      _pushPage(context, DropdownPage());
      break;
    case Menu.FloatingAction:
      _pushPage(context, FloatingActionPage());
      break;
    default:
      break;
  }
}

void _pushPage(BuildContext context, Widget page) async {
  await Navigator.of(context)
      .push(MaterialPageRoute<void>(builder: (_) => page));
}

class PopupMenuPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.purpleAccent,
      ),
    );
  }
}

class DropdownPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}

class FloatingActionPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
