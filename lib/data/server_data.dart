class RoomInfo {
  final String roomId;
  final String roomName;
  final List<PlayerInfo> playerList;
  final bool isJoin;
  final DateTime timeStamp;
  //DateTime.parse(dateString)

  const RoomInfo({
    required this.roomId,
    required this.roomName,
    required this.playerList,
    required this.isJoin,
    required this.timeStamp,
  });
}

class PlayerInfo {
  final String playerId;
  final bool onOff;
  final bool isMaster;

  const PlayerInfo({
    required this.playerId,
    required this.onOff,
    required this.isMaster,
  });
}
