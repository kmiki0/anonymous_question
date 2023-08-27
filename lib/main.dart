import 'package:flutter/material.dart';
import 'package:anonymous_question/screens/room_setting_page.dart';
import 'package:anonymous_question/screens/guest_page.dart';

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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const GuestPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Material(
                elevation: 10,
                color: Colors.transparent,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_home_rounded,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text(
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
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.accessibility_new_outlined,
                        color: Colors.white,
                        size: 100,
                      ),
                      Text('Guest',
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
      ),
    );
  }
}
