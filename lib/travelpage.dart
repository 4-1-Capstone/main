import 'package:flutter/material.dart';
import 'homepage.dart';
import 'anidetailpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TravelPage(),
    );
  }
}

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  final List<Map<String, String>> _locations = [
    {
      'title': '토토로',
      'subtitle': '지브리, 미야자키 하야오',
      'image': 'assets/totoro.png', // 이미지 경로
      'description': '이건 토토로에 대한 설명이다. 토토로는 미야자키 하야오 감독의 애니메이션 영화입니다.',
    },
    {
      'title': '너의 이름은',
      'subtitle': '신카이 마코토',
      'image': 'assets/your_name.jpg',
      'description': '이건 너의 이름은에 대한 설명이다. 신카이 마코토 감독의 애니메이션 영화입니다.',
    },
    {
      'title': '슬램덩크',
      'subtitle': '농구',
      'image': 'assets/slamdunk.jpg',
      'description': '이건 슬램덩크에 대한 설명이다. 슬램덩크는 농구를 주제로 한 애니메이션입니다.',
    },
    {
      'title': '센과 치히로의 행방불명',
      'subtitle': '지브리, 미야자키 하야오',
      'image': 'assets/spirited_away.png',
      'description': '이건 센과 치히로의 행방불명에 대한 설명이다. 미야자키 하야오 감독의 애니메이션 영화입니다.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('애니메이션 리스트'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.asset(
                _locations[index]['image']!,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(
                _locations[index]['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_locations[index]['subtitle']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimationDetailPage(
                      title: _locations[index]['title']!,
                      subtitle: _locations[index]['subtitle']!,
                      image: _locations[index]['image']!,
                      description: _locations[index]['description']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}