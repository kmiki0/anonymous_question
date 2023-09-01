import 'package:flutter/material.dart';
import 'package:anonymous_question/screens/room_setting_page.dart';
import 'package:anonymous_question/screens/room_select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'ZenKurenaido',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 通信用のクラス
class SocketManager {
  SocketManager._();
  static final instance = SocketManager._();
  String playerId = '';
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ホスト画面への遷移
  void _hostScreenTransition() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const RoomSettingPage()));
    });
  }

  // ゲスト画面への遷移
  void _guestScreenTransition() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const RoomSelectPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // 画面サイズ取得
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('匿名質問箱', style: TextStyle(fontSize: 30)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Material(
                    elevation: 10,
                    color: Colors.transparent,
                    child: Container(
                      height: mediaSize.height * 0.22,
                      width: mediaSize.width * 0.365,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_home_rounded,
                            color: Colors.white,
                            size: mediaSize.width / 4,
                          ),
                          const Text(
                            'Host',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _hostScreenTransition();
                  },
                ),
                GestureDetector(
                  child: Material(
                    elevation: 10,
                    color: Colors.transparent,
                    child: Container(
                      height: mediaSize.height * 0.22,
                      width: mediaSize.width * 0.365,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.accessibility_new_outlined,
                            color: Colors.white,
                            size: mediaSize.width / 4,
                          ),
                          const Text('Guest',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _guestScreenTransition();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
