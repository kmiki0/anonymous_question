import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:anonymous_question/data/server_data.dart';

class RoomInfoCard extends StatelessWidget {
  final int index;
  final RoomInfo roomInfo;

  const RoomInfoCard({Key? key, required this.index, required this.roomInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int playerCount = roomInfo.playerList.length;
    final mediaSize = MediaQuery.of(context).size;
    double cardHeight = mediaSize.height / 6.6;

    // 11人以上の場合は、cardHeight*2にする
    if (playerCount > 10) {
      cardHeight = cardHeight * 1.2;
    }

    return Container(
      margin: const EdgeInsets.all(5),
      height: cardHeight,
      child: Material(
        type: MaterialType.button,
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            // 選択したルームへ接続
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            // 左右に余白
            padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '$index. ',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      roomInfo.roomName,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Created: ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy/MM/dd(E) HH:mm')
                          .format(roomInfo.timeStamp),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // 11人以上の場合は、アイコンの表示を2行にする
                if (playerCount > 10)
                  Column(
                    children: [
                      const IconDisplay(count: 11),
                      IconDisplay(count: playerCount - 11),
                    ],
                  )
                else
                  IconDisplay(count: playerCount)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconDisplay extends StatelessWidget {
  final int count;

  const IconDisplay({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (index) {
        return const Padding(
          padding: EdgeInsets.only(top: 5.0, left: 5.0, right: 3.0),
          child: Icon(Icons.person,
              color: Color.fromARGB(255, 135, 135, 135)), // ここで表示するアイコンを指定
        );
      }),
    );
  }
}
