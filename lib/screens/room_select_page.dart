import 'package:flutter/material.dart';

class RoomSelectPage extends StatefulWidget {
  const RoomSelectPage({super.key});

  @override
  State<RoomSelectPage> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // サーバーから切断
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(100, 0, 0, 0),
            )),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('GuestPage')],
        ),
      ),
    );
  }
}
