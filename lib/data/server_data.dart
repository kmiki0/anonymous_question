class ServerData {
  final String roomKey;
  final String roomName;
  final DateTime timestamp;

  const ServerData({
    required this.roomName,
    required this.roomKey,
    required this.timestamp,
  });
}
