import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  List<String> messages = [];
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    // サーバーに接続
    channel = WebSocketChannel.connect(
      Uri.parse('ws://ik1-218-79096.vs.sakura.ne.jp:5000'),
    );
    channel.stream.listen((message) {
      // setState(() {
      print('受信メッセージ : $message');
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    // メッセージ 送信
    void sendMessage() {
      if (controller.text.isNotEmpty) {
        channel.sink.add(controller.text);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // サーバーから切断
              channel.sink.close();
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
                controller: controller,
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
            GestureDetector(
              onTap: () {
                // ルーム作成
                // channel.sink.add('create');
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // ルーム作成
                  sendMessage();
                  // テキスト初期化
                  controller.clear();
                },
                child: const Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
