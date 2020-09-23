import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Silly Hacks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // sleep(const Duration(seconds: 1));
    alignment = Alignment.bottomCenter;

    audio.seek(Duration.zero);
    audio.play();
  }

  final audio = AudioPlayer();

  static const initialPosition = Alignment.bottomCenter;

  var alignment = initialPosition;

  @override
  void initState() {
    super.initState();
    audio.setAsset('assets/sounds/snorlax.mp3');
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onLongPress: () {
          setState(() {
            alignment = Alignment(0.0, 0.4);
            audio.seek(Duration.zero);
            audio.play();
          });
        },
        onLongPressEnd: (details) {
          setState(() {
            alignment = Alignment.bottomCenter;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            alignment += Alignment(details.delta.dx, details.delta.dy) / 100;
            // print(Alignment(details.delta.dx, details.delta.dy));
          });
        },
        child: Column(children: [
          Expanded(
            child: Container(
              color: Colors.lightBlue,
              child: Align(
                alignment: alignment,
                child: Image.asset('assets/images/head.png'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/body.png'),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Snor',
        child: Transform.rotate(angle: _counter / 10, child: Text('snor')),
      ),
    );
  }
}
