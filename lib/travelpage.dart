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
      debugShowCheckedModeBanner: false,
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
                      relatedPlaces: [
                        {
                          'title': '사야마 구릉',
                          'description': '사야마 구릉은 토토로의 숲 또는 토토로의 숲으로 알려진 곳이며 미야자키 하야오의 "토토로"에서 토토로가 사는 숲입니다.',
                          'image': 'assets/sayama.jpg'
                        },
                        {
                          'title': '코스기노 오오스기',
                          'description': '코스기노 오오스기는 지브리 영화 이웃집 토토로의 토토로를 닮은 것으로 유명합니다.',
                          'image': 'assets/osugi.jpg'
                        },
                        {
                          'title': '지브리 박물관',
                          'description': '도쿄의 미타카시에 위치한 지브리 박물관은 미야자키 하야오 감독이 직접 디자인한 박물관입니다.',
                          'image': 'assets/ghibli.jpg'
                        }
                      ],
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

class AnimationDetailPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String description;
  final List<Map<String, String>> relatedPlaces;

  AnimationDetailPage({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.description,
    required this.relatedPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('애니메이션 상세정보'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text(description),
                  SizedBox(height: 16),
                  Text(
                    '관련 여행지',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: relatedPlaces.map((place) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.asset(
                            place['image']!,
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            place['title']!,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(place['description']!),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}