import 'package:flutter/material.dart';
import 'package:anonymous_question/utils/socket_client.dart';
import 'package:anonymous_question/main.dart';
import 'package:anonymous_question/consts/setting.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:typeracer_tutorial/providers/client_state_provider.dart';
// import 'package:typeracer_tutorial/providers/game_state_provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  // bool _isPlaying = false;

  // サーバーに接続
  connect() async {
    await http.get(Uri.parse('${URL.apiServer}/connect'));
  }

  // create game
  createGame(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('create-game', {
        'nickname': nickname,
      });
    }
  }

  // ルームへ接続
  joinGame(String roomId) {
    if (roomId.isNotEmpty) {
      _socketClient.emit('join-game', {
        'roomId': roomId,
      });
    }
  }

  // ルームへ接続情報を送信
  sendUserInput(String value, String gameID) {
    _socketClient.emit('userInput', {
      'userInput': value,
      'gameID': gameID,
    });
  }

  // ルームから退出
  leaveRoom() {
    _socketClient.emit('leave-room');
  }

  // サーバーから切断
  disconnect() {
    // SocketId を空にする
    SocketManager.instance.playerId = '';
    _socketClient.emit('disconnect-request');
  }
  // listeners
  // サーバー接続時に、playerIdを取得
  setPlayerIdListener(BuildContext context) {
    _socketClient.on('setPlayerId', (playerId) {
      if (playerId.isNotEmpty) {
        SocketManager.instance.playerId = playerId;
      }
    });
  }

  // サーバー接続時に、playerIdを取得
  isPlayingListener(BuildContext context) {
      _socketClient.on('isPlaying', (isPlaying) {
          if (playerId.isNotEmpty) {
              SocketManager.instance.isPlaying = isPlaying;
          }
      });
  }


  // updateGameListener(BuildContext context) {
  //   _socketClient.on('updateGame', (data) {

  //     if (data['_id'].isNotEmpty && !_isPlaying) {
  //       Navigator.pushNamed(context, '/game-screen');
  //       _isPlaying = true;
  //     }
  //   });
  // }

  // startTimer(playerId, gameID) {
  //   _socketClient.emit(
  //     'timer',
  //     {
  //       'playerId': playerId,
  //       'gameID': gameID,
  //     },
  //   );
  // }

  notCorrectGameListener(BuildContext context) {
    _socketClient.on(
      'notCorrectGame',
      (data) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data),
        ),
      ),
    );
  }

  // updateTimer(BuildContext context) {
  //   final clientStateProvider =
  //       Provider.of<ClientStateProvider>(context, listen: false);
  //   _socketClient.on('timer', (data) {
  //     clientStateProvider.setClientState(data);
  //   });
  // }

  // updateGame(BuildContext context) {
  //   _socketClient.on('updateGame', (data) {
  //     final gameStateProvider =
  //         Provider.of<GameStateProvider>(context, listen: false)
  //             .updateGameState(
  //       id: data['_id'],
  //       players: data['players'],
  //       isJoin: data['isJoin'],
  //       words: data['words'],
  //       isOver: data['isOver'],
  //     );
  //   });
  // }

  gameFinishedListener() {
    _socketClient.on(
      'done',
      (data) => _socketClient.off('timer'),
    );
  }
}
