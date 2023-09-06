import 'package:flutter/material.dart';
import 'package:anonymous_question/utils/socket_methods.dart';

class OnOffPage extends StatefulWidget {
  const OnOffPage({super.key});

  @override
  State<OnOffPage> createState() => _OnOffPageState();
}

class _OnOffPageState extends State<OnOffPage> {
  // final SocketMethods _socketMethods = SocketMethods();

  final Color _frontColor = const Color.fromRGBO(255, 90, 120, 1);
  final Color _backColor = const Color.fromRGBO(150, 50, 60, 1);

  // top
  late double _fromTop;
  late double _toTop;
  late double _top = _fromTop;

  // fromとtoのフラグ
  bool isFrom = true;

  @override
  Widget build(BuildContext context) {
        // 画面サイズ取得
    final mediaSize = MediaQuery.of(context).size;

    _fromTop = mediaSize.height / 2.725;
    _toTop = mediaSize.height / 2.6;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // サーバーから切断
              // channel.sink.close();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(100, 0, 0, 0),
            )),
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Align(
                alignment: const Alignment(0, 0.15),
                child: Container(
                  width: 150,
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC8C8C8),
                  ),
                ),
              ),
            ),
            Center(
              child: Align(
                alignment: const Alignment(0, 0.05),
                child: Container(
                  width: 150,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFD4D4D4), width: 1.3),
                    color: const Color.fromRGBO(236, 236, 236, 1),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Align(
                  alignment: const Alignment(0, 0.04),
                  child: Container(
                    width: 100,
                    height: 98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _backColor,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: _top,
              left: mediaSize.width / 2.63,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _changeTop();
                    // _socketMethods.sendData('on');
                  },
                  child: Container(
                    width: 100,
                    height: 98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: _frontColor,
                      border: Border.all(color: _backColor, width: 1),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.3, 0.9],
                        colors: [
                          _frontColor,
                          const Color.fromARGB(255, 224, 104, 104),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ] 
        ),
      ),
    );
  }

  void _changeTop() {
    setState(() {
      this.isFrom = !this.isFrom;
      this._top = this.isFrom ? _fromTop : _toTop;
    });
  }
}
