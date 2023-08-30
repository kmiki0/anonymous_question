import 'package:flutter/material.dart';
import 'package:anonymous_question/data/server_data.dart';
import 'package:anonymous_question/widgets/room_info.dart';

class RoomSelectPage extends StatefulWidget {
  const RoomSelectPage({super.key});

  @override
  State<RoomSelectPage> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSelectPage> {
  List<RoomInfo> roomList = new List<RoomInfo>.generate(
    10,
    (int index) => RoomInfo(
      roomId: 'hKM7h0qA6Ftqpxda',
      roomName: 'testRoom',
      maxPlayers: '10',
      isJoin: true,
      timeStamp: DateTime.now(),
    ),
  );

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
      body: ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (BuildContext context, int index) {
          return RoomInfoCard(
            index: index + 1,
            roomInfo: roomList[index],
          );
        },
      ),
    );
  }
}
