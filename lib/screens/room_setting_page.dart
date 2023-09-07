import 'package:anonymous_question/main.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:anonymous_question/utils/socket_methods.dart';

import '../consts/setting.dart';


class RoomSettingPage extends StatefulWidget {
  const RoomSettingPage({super.key});

  @override
  State<RoomSettingPage> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSettingPage> {
  late final Socket _socket;
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
      // PlayerIdが空の場合、サーバーに接続
    if (SocketManager.instance.playerId.isEmpty) {
      _socket = io(
        URL.apiServer,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build()
      );

      // WebSocketに接続
      _socket.connect();
    }
    // サーバー接続時、playerIdを取得
    _socketMethods.setPlayerIdListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // サーバーから切断
              _socketMethods.disconnect();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(100, 0, 0, 0),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ルーム設定', style: TextStyle(fontSize: 30)),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: _controller,
                validator: (String? value) {
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'ルーム名を入力してください',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // ルーム作成
                _socketMethods.createGame(
                  _controller.text,
                );
                // テキスト初期化
                _controller.clear();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Create',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
