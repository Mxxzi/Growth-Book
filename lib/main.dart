import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:growthbook_sdk_flutter/growthbook_sdk_flutter.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Growth Book'),
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
  bool showCounterIcons = false;
  bool showAddIcon = false;
  bool showSubIcon = false;
  @override
  void initState() {
    // TODO: implement initState
    initGrowthBook();
    super.initState();
  }

  void initGrowthBook() async {
    GrowthBookSDK gb = await GBSDKBuilderApp(
      hostURL: 'https://cdn.growthbook.io/',
      apiKey: "sdk-60UsdQAHbqhZ1vEe",
      growthBookTrackingCallBack: (gbExperiment, gbExperimentResult) {
        // TODO: Use your real analytics tracking system
        log("Viewed Experiment");
        log("Experiment Id: " + gbExperiment.key);
      },
    ).initialize();

    if (gb.feature("counter").on) {
      // Feature is enabled!
      setState(() {
        showCounterIcons = true;
        showAddIcon = true;
        showSubIcon = true;
      });
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: showCounterIcons
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (showAddIcon)
                      FloatingActionButton(
                        onPressed: _incrementCounter,
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                    if (showSubIcon)
                      FloatingActionButton(
                        onPressed: _decrementCounter,
                        tooltip: 'decrement',
                        child: const Icon(Icons.minimize_outlined),
                      ),
                  ],
                ),
              )
            : null // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
