import 'dart:convert';
import 'package:anonymous_question/screens/on_off_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:anonymous_question/data/server_data.dart';
import 'package:anonymous_question/widgets/room_info.dart';
import 'package:anonymous_question/utils/socket_client.dart';
import 'package:anonymous_question/utils/socket_methods.dart';
import 'package:anonymous_question/consts/setting.dart';
import 'package:anonymous_question/main.dart';


class RoomSelectPage extends StatefulWidget {
  const RoomSelectPage({super.key});

  @override
  State<RoomSelectPage> createState() => _RoomSettingState();
}

class _RoomSettingState extends State<RoomSelectPage> {
  final _socketClient = SocketClient.instance.socket!;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    // サーバー接続時、playerIdを取得
    _socketMethods.setPlayerIdListener(context);
    // ルームへ接続した際に、自分がルームへ参加したかどうかを取得
    isRoomJoinListener(context);
  }

  // ONOFF画面への遷移
  void _onOffScreenTransition() {
    setState(() {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const OnOffPage()));
    });
  }

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
      body: FutureBuilder<List<RoomInfo>>(
        future: _fetchRoomList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final roomList = snapshot.data!;
            return ListView.builder(
              itemCount: roomList.length,
              itemBuilder: (BuildContext context, int index) {
                return RoomInfoCard(
                  index: index + 1,
                  roomInfo: roomList[index],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  // 画面遷移するため、ここに記載
  isRoomJoinListener(BuildContext context) {
    _socketClient.on('isRoomJoin', (playerId) {
      print('SocketManager.instance.playerId: ${SocketManager.instance.playerId}');
      // ルームへ参加したplayerIdが自分と同じなら、画面遷移
      if (playerId == SocketManager.instance.playerId) {
        _onOffScreenTransition();
      }
    });
  }
  // HomeFeedのデータを取得 引数はisRefresh
  Future<List<RoomInfo>> _fetchRoomList() async {
    const urlParam = '${URL.apiServer}/getRoomList';
    // データを取得
    final response = await http.get(Uri.parse(urlParam));

    // データを取得できた場合
    if (response.statusCode == 200) {
      // JSONをvideoクラスに変換
      final roomData = json.decode(response.body);
      // データをリストに変換して、返す
      return List<RoomInfo>.from(
        roomData.map(
          (json) => RoomInfo(
            roomId: json['roomId'],
            roomName: json['roomName'],
            isJoin: json['isJoin'],
            playerList: List<PlayerInfo>.from(
              json['playerList'].map(
                (json) => PlayerInfo(
                  playerId: json['playerId'],
                  onOff: json['onOff'],
                  isMaster: json['isMaster'],
                ),
              ),
            ),
            timeStamp: DateTime.parse(json['timeStamp']),
          ),
        ),
      );
    } else {
      throw Exception('ルーム情報の取得に失敗しました');
    }
  }
}
