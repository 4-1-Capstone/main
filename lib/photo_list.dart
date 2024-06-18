import 'package:flutter/material.dart';
import 'photo.dart';

class ChallengeBoard extends StatelessWidget {
  final List<Map<String, dynamic>> boards = [
    {
      'title': '너의 이름은',
      'subtitle': '두 남녀 주인공이 만났던 신사 계단',
      'image': 'assets/kimino.jpg'
    },
    {
      'title': '스즈메의 행방불명',
      'subtitle': '사람 많은 기차역에서 미미즈가 덮쳐오는 장면 ',
      'image': 'assets/suzume.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('명장면 챌린지'),
      ),
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoUploadPage(board: boards[index]),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    boards[index]['image'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      boards[index]['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(boards[index]['subtitle']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
