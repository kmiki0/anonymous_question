import 'package:flutter/material.dart';
import 'package:anonymous_question/utils/socket_methods.dart';

class OnOffPage extends StatefulWidget {
  const OnOffPage({super.key});

  @override
  State<OnOffPage> createState() => _OnOffPageState();
}

class _OnOffPageState extends State<OnOffPage> {
  final SocketMethods _socketMethods = SocketMethods();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
