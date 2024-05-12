import 'dart:io';
import 'package:flutter/material.dart';
import 'package:capybara/chat_form.dart';
import 'package:provider/provider.dart';
import 'package:capybara/capybara_action.dart';
import 'package:capybara/capybara_model.dart';
import 'package:capybara/capybara_description.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:capybara/global_config.dart';
import 'package:local_assets_server/local_assets_server.dart';

String _address = '';
int _port = 8080;

initServer() async {
  final server = LocalAssetsServer(
    address: InternetAddress.loopbackIPv4,
    assetsBasePath: 'www',
    logger: const DebugLogger(),
  );

  final address = await server.serve();
  _address = address.address;
  _port = server.boundPort!;
}

Future<void> main() async {
  await dotenv.load();
  await initServer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capybara',
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 51, 51, 75)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '你的打工牛马'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => CapybaraAction(
                  action: 'walk',
                  emotion: '开心',
                  movement: 'around',
                  description: '牛马打工中')),
          ChangeNotifierProvider(
              create: (context) => GlobalConfig(
                  baseURL: (dotenv.env['BASE_URL'] ?? 'http://'),
                  localAssetsServer: _address,
                  localAssetsServerPort: _port.toString()))
        ],
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Center(child: Text(widget.title)),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE1, or press "p" in the console), to see the
                // wireframe for each widget.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CapybaraModel(),
                  const CapybaraDescription(),
                  // 使用Spacer来在底部创建空间
                  Container(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 30.0),
                    child: const ChatForm(),
                  ),
                ],
              ),
            )));
  }
}
