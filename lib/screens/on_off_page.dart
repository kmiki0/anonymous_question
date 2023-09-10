import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:anonymous_question/utils/socket_methods.dart';
import 'package:anonymous_question/utils/sounds.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class OnOffPage extends StatefulWidget {
  const OnOffPage({super.key});

  @override
  State<OnOffPage> createState() => _OnOffPageState();
}

class _OnOffPageState extends State<OnOffPage> {
  final SocketMethods _socketMethods = SocketMethods();
  final SoundService _sounds = SoundService();


  final Color _frontColor = const Color.fromRGBO(255, 90, 120, 1);
  final Color _backColor = const Color.fromRGBO(150, 50, 60, 1);

  // top
  late double _fromTop;
  late double _toTop;
  late double _top = _fromTop;

  bool isBlur = false;

  late String _count = '1';

  // fromとtoのフラグ
  bool isFrom = true;

  @override
  Widget build(BuildContext context) {
        // 画面サイズ取得
    final mediaSize = MediaQuery.of(context).size;

    _fromTop = (mediaSize.height / 3.2).round().toDouble();
    _toTop = (mediaSize.height / 3.05).round().toDouble();

    final hoge = true;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // ルームから退出
              _socketMethods.leaveRoom();
              // channel.sink.close();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(100, 0, 0, 0),
            )),
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab( icon: const Icon(Icons.pan_tool_outlined, color: Colors.black38,)),
                    if(hoge) 
                    const Tab( icon: const Icon(Icons.content_paste_search_rounded, color: Colors.black38,)),
                  ],
                ),
              Expanded(
                child: TabBarView(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: (mediaSize.height / 2.9).round().toDouble(),
                          left: (mediaSize.width / 3.15).round().toDouble(),
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
                        Positioned(
                          top: (mediaSize.height / 3.25).round().toDouble(),
                          left: (mediaSize.width / 3.15).round().toDouble(),
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
                          top: (mediaSize.height / 3.05).round().toDouble(),
                          left: (mediaSize.width / 2.6).round().toDouble(),
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
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          top: _top,
                          left: (mediaSize.width / 2.6).round().toDouble(),
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
                      ] 
                    ),
                    if(hoge)
                    Scaffold(
                      body: Center(
                        child: Text(
                          _count, 
                          style: const TextStyle(
                            fontFamily: 'Toma Slab', 
                            fontSize: 200
                          )
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
          ),
          ),
          if(isBlur)
          SizedBox(
            width: mediaSize.width,
            height: mediaSize.height,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            )
          ),
        ],
      ),
    floatingActionButton: SpeedDial(
      childMargin: const EdgeInsets.only(
        top: 20,
        bottom: 10,
        right: 10,
        left: 10,
      ),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      closeManually: false,
      curve: Curves.bounceIn,
      activeBackgroundColor: Colors.red[300],
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.blue[300],
      foregroundColor: Colors.black,
      elevation: 8.0,
      children: [
        SpeedDialChild(
          child: Icon(Icons.timer_off_sharp),
          label: '集計 ストップ',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: ImageIcon(
            const AssetImage('assets/icons/sercret.png'),
            size: 50.0,
          ),
          label: 'モザイク',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            setState(() {
              isBlur = !isBlur;
            });
          },
        ),
      ],
    ),
    );
  }

  void _changeTop() {
    setState(() {
      this.isFrom = !this.isFrom;
      this._top = this.isFrom ? _fromTop : _toTop;
      // SE
      isFrom ? _sounds.playSound('ON') : _sounds.playSound('OFF');
    });
  }
}
