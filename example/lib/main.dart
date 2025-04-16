import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_controller_override/scroll_controller_override.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late ScrollControllerOverride scrollController;
  double top = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollControllerOverride(overrideMethod: ScrollOverrideMethod(
      applyUserOffset: (double delta, void Function(double delta) superMethod) {
        bool listShouldScroll = scrollController.position.pixels > 0.0;
        if (!listShouldScroll) {
          double newVal = top + delta;
          newVal = max(0, newVal);
          if (newVal != top) {
            setState(() {
              top = newVal;
            });
          } else {
            superMethod(delta);
          }
        } else {
          superMethod(delta);
        }
      },
    ));
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, top),
            child: ScrollPointerListener(
              onPointerDown: (i) {
                print("onPointerDown");
              },
              onPointerUp: (i) {
                print("onPointerUp");
              },
              onPointerCancel: (i) {
                print("onPointerCancel");
              },
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(
                        20,
                        (e) {
                          return Container(height: 100, width: double.infinity, color: Colors.amber, child: Placeholder());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
