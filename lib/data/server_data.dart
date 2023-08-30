class RoomInfo {
  final String roomId;
  final String roomName;
  final String maxPlayers;
  final bool isJoin;
  final DateTime timeStamp;
  //DateTime.parse(dateString)

  const RoomInfo({
    required this.roomId,
    required this.roomName,
    required this.maxPlayers,
    required this.isJoin,
    required this.timeStamp,
  });
}
