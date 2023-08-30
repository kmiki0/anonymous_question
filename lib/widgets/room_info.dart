import 'package:flutter/material.dart';
import 'package:anonymous_question/data/server_data.dart';

class RoomInfoCard extends StatelessWidget {
  final int index;
  final RoomInfo roomInfo;

  const RoomInfoCard({Key? key, required this.index, required this.roomInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      height: 100,
      child: GestureDetector(
        onTap: () {
          // 選択したルームへ接続
        },
        child: Material(
          elevation: 4,
          color: const Color.fromARGB(0, 120, 120, 120),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                // 左右に余白
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '$index. ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      roomInfo.roomName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
