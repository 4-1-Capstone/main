import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'travelpage.dart';
import 'mappage.dart';
import 'userpage.dart';
import 'anidetailpage.dart';
import 'favorite_deleted_provider.dart';
import 'character_pose.dart';
import 'photo_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteAndDeletedProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Ani_gation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    TravelPage(),
    MapPage(),
    ChallengeBoard(),
    CharacterSelectionApp(),
    // Text('Special Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TravelPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChallengeBoard())
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CharacterSelectionApp()),
      );
    }
    else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: '홈'),
              Tab(text: '추천'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            RecommendTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '테마여행'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp), label: '챌린지'),
            BottomNavigationBarItem(icon: Icon(Icons.wifi_protected_setup), label: '포즈 추천'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _locations = [
    {
      'title': '너의 이름은',
      'subtitle': '신카이 마코토',
      'image': 'assets/your_name.jpg',
      'description': '이건 너의 이름은에 대한 설명이다. 신카이 마코토 감독의 애니메이션 영화입니다.',
      'relatedPlaces': 'relatedPlaces'
    },
    {
      'title': '토토로',
      'subtitle': '지브리, 미야자키 하야오',
      'image': 'assets/totoro.png',
      'description': '이건 토토로에 대한 설명이다. 토토로는 미야자키 하야오 감독의 애니메이션 영화입니다.',
      'relatedPlaces': 'relatedPlaces'
    },
    {
      'title': '슬램덩크',
      'subtitle': '농구',
      'image': 'assets/slamdunk.jpg',
      'description': '이건 슬램덩크에 대한 설명이다. 슬램덩크는 농구를 주제로 한 애니메이션입니다.',
      'relatedPlaces': 'relatedPlaces'
    },
    {
      'title': '센과 치히로',
      'subtitle': '지브리, 미야자키 하야오',
      'image': 'assets/spirited_away.png',
      'description': '이건 센과 치히로의 행방불명에 대한 설명이다. 미야자키 하야오 감독의 애니메이션 영화입니다.',
      'relatedPlaces': 'relatedPlaces'
    },
  ];

  void _searchAnimation() {
    String searchQuery = _searchController.text.toLowerCase().trim();
    bool found = false;

    for (var location in _locations) {
      if (location['title']!.toLowerCase().contains(searchQuery)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimationDetailPage(
              title: location['title']!,
              subtitle: location['subtitle']!,
              image: location['image']!,
              description: location['description']!,
              relatedPlaces: _getRelatedPlaces(location['title']!),
            ),
          ),
        );
        found = true;
        break;
      }
    }

    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('정보가 없습니다'),
        ),
      );
    }
  }

  List<Map<String, String>> _getRelatedPlaces(String title) {
    if (title == '토토로') {
      return [
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
      ];
    }
    // 다른 애니메이션에 대해서도 같은 방식으로 관련 장소를 추가할 수 있습니다.
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '어떤 애니메이션을 찾으시나요?',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.arrow_circle_right),
                  onPressed: _searchAnimation,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onSubmitted: (value) => _searchAnimation(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryItem(context, 'assets/your_name.jpg', '너의 이름은', '신카이 마코토', 'assets/your_name.jpg', '이건 너의 이름은에 대한 설명이다. 신카이 마코토 감독의 애니메이션 영화입니다.'),
                _buildCategoryItem(context, 'assets/totoro.png', '토토로', '지브리, 미야자키 하야오', 'assets/totoro.png', '이건 토토로에 대한 설명이다. 토토로는 미야자키 하야오 감독의 애니메이션 영화입니다.'),
                _buildCategoryItem(context, 'assets/slamdunk.jpg', '슬램덩크', '농구', 'assets/slamdunk.jpg', '이건 슬램덩크에 대한 설명이다. 슬램덩크는 농구를 주제로 한 애니메이션입니다.'),
                _buildCategoryItem(context, 'assets/spirited_away.png', '센과 치히로', '지브리, 미야자키 하야오', 'assets/spirited_away.png', '이건 센과 치히로의 행방불명에 대한 설명이다. 미야자키 하야오 감독의 애니메이션 영화입니다.'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              color: Colors.grey[300],
              height: 150,
              child: Center(child: Text('추천 테마')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('일본 불꽃 축제', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecommendationItem('도쿄 가츠시카 납량 불꽃놀이', 'assets/katsushika.jpg'),
                      _buildRecommendationItem('도쿄 아다치 불꽃놀이', 'assets/adachi.jpg'),
                      _buildRecommendationItem('오사카 비와코 불꽃축제', 'assets/biwa.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String assetImagePath, String label, String subtitle, String image, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimationDetailPage(
              title: label,
              subtitle: subtitle,
              image: image,
              description: description,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(assetImagePath, width: 40, height: 40, fit: BoxFit.cover,),
          ),
          SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

//Widget _buildCategoryItem(BuildContext context, String assetImagePath, String label, String subtitle, String image, String description) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AnimationDetailPage(
//               title: label,
//               subtitle: subtitle,
//               image: image,
//               description: description,
//             ),
//           ),
//         );
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipOval(
//             child: Image.asset(assetImagePath, width: 40, height: 40, fit: BoxFit.cover,),
//           ),
//           SizedBox(height: 5),
//           Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }

  Widget _buildRecommendationItem(String name, String assetImagePath) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Container(
        width: 150,
        color: Colors.grey[300],
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: Colors.grey[400],
                child: Image.asset(assetImagePath, fit: BoxFit.cover),
              ),
              SizedBox(height: 5),
              Text(name, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

class RecommendTab extends StatefulWidget {
  @override
  _RecommendTabState createState() => _RecommendTabState();
}

class _RecommendTabState extends State<RecommendTab> {
  List<Map<String, String>> destinations = [
    {
      'name': '스가신사',
      'description': '너의 이름은에서 두 남녀가 만났던 장소',
      'image': 'assets/kimino_rec.JPG'
    },
    {
      'name': '가마쿠라코코마에역',
      'description': '슬램덩크 오프닝 장면의 모티브가 된 장소',
      'image': 'assets/slam_rec.JPG'
    },
    {
      'name': '사야마 구릉',
      'description': '토토로 숲의 모티브가 된 장소',
      'image': 'assets/totoro_rec.JPG'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: destinations.map((destination) {
          return Dismissible(
            key: Key(destination['name']!),
            onDismissed: (direction) {
              String action;
              if (direction == DismissDirection.endToStart) {
                Provider.of<FavoriteAndDeletedProvider>(context, listen: false)
                    .addDeletedItem(destination['name']!);
                action = '삭제됨';
              } else {
                Provider.of<FavoriteAndDeletedProvider>(context, listen: false)
                    .addFavoriteItem(destination['name']!);
                action = '찜됨';
              }

              setState(() {
                destinations.remove(destination);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${destination['name']} $action'),
                ),
              );
            },
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(destination['image']!),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      destination['name']!,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      destination['description']!,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
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


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'travelpage.dart';
// import 'mappage.dart';
// import 'userpage.dart';
// import 'anidetailpage.dart';
// import 'favorite_deleted_provider.dart';
// import 'character_pose.dart';
// import 'photo_list.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => FavoriteAndDeletedProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(title: 'Ani_gation'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;

//   MyHomePage({required this.title});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   static final List<Widget> _widgetOptions = <Widget>[
//     HomeTab(),
//     TravelPage(),
//     MapPage(),
//     ChallengeBoard(),
//     CharacterSelectionApp(),
//     // Text('Special Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
//   ];

//   void _onItemTapped(int index) {
//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => TravelPage()),
//       );
//     } else if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => MapPage()),
//       );
//     } else if (index == 3) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => ChallengeBoard())
//       );
//     } else if (index == 4) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CharacterSelectionApp()),
//       );
//     }
//     else {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.person),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserPage()),
//                 );
//               },
//             ),
//           ],
//           bottom: TabBar(
//             tabs: [
//               Tab(text: '홈'),
//               Tab(text: '추천'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             HomeTab(),
//             RecommendTab(),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
//             BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '테마여행'),
//             BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도'),
//             BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp), label: '챌린지'),
//             BottomNavigationBarItem(icon: Icon(Icons.wifi_protected_setup), label: '포즈 추천'),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.blue,
//           onTap: _onItemTapped,
//           type: BottomNavigationBarType.fixed,
//         ),
//       ),
//     );
//   }
// }

// class HomeTab extends StatefulWidget {
//   @override
//   _HomeTabState createState() => _HomeTabState();
// }

// class _HomeTabState extends State<HomeTab> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, String>> _locations = [
//     {
//       'title': '너의 이름은',
//       'subtitle': '신카이 마코토',
//       'image': 'assets/your_name.jpg',
//       'description': '이건 너의 이름은에 대한 설명이다. 신카이 마코토 감독의 애니메이션 영화입니다.'
//     },
//     {
//       'title': '토토로',
//       'subtitle': '지브리, 미야자키 하야오',
//       'image': 'assets/totoro.png',
//       'description': '이건 토토로에 대한 설명이다. 토토로는 미야자키 하야오 감독의 애니메이션 영화입니다.'
//     },
//     {
//       'title': '슬램덩크',
//       'subtitle': '농구',
//       'image': 'assets/slamdunk.jpg',
//       'description': '이건 슬램덩크에 대한 설명이다. 슬램덩크는 농구를 주제로 한 애니메이션입니다.'
//     },
//     {
//       'title': '센과 치히로',
//       'subtitle': '지브리, 미야자키 하야오',
//       'image': 'assets/spirited_away.png',
//       'description': '이건 센과 치히로의 행방불명에 대한 설명이다. 미야자키 하야오 감독의 애니메이션 영화입니다.'
//     },
//   ];

//   void _searchAnimation() {
//     String searchQuery = _searchController.text.toLowerCase().trim();
//     bool found = false;

//     for (var location in _locations) {
//       if (location['title']!.toLowerCase().contains(searchQuery)) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AnimationDetailPage(
//               title: location['title']!,
//               subtitle: location['subtitle']!,
//               image: location['image']!,
//               description: location['description']!,
//             ),
//           ),
//         );
//         found = true;
//         break;
//       }
//     }

//     if (!found) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('정보가 없습니다'),
//         ),
//       );
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: '어떤 애니메이션을 찾으시나요?',
//                 prefixIcon: Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.arrow_circle_right),
//                   onPressed: _searchAnimation,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//               ),
//               onSubmitted: (value) => _searchAnimation(),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: GridView.count(
//               crossAxisCount: 4,
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               children: [
//                 _buildCategoryItem(context, 'assets/your_name.jpg', '너의 이름은', '신카이 마코토', 'assets/your_name.jpg', '이건 너의 이름은에 대한 설명이다. 신카이 마코토 감독의 애니메이션 영화입니다.'),
//                 _buildCategoryItem(context, 'assets/totoro.png', '토토로', '지브리, 미야자키 하야오', 'assets/totoro.png', '이건 토토로에 대한 설명이다. 토토로는 미야자키 하야오 감독의 애니메이션 영화입니다.'),
//                 _buildCategoryItem(context, 'assets/slamdunk.jpg', '슬램덩크', '농구', 'assets/slamdunk.jpg', '이건 슬램덩크에 대한 설명이다. 슬램덩크는 농구를 주제로 한 애니메이션입니다.'),
//                 _buildCategoryItem(context, 'assets/spirited_away.png', '센과 치히로', '지브리, 미야자키 하야오', 'assets/spirited_away.png', '이건 센과 치히로의 행방불명에 대한 설명이다. 미야자키 하야오 감독의 애니메이션 영화입니다.'),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Container(
//               color: Colors.grey[300],
//               height: 150,
//               child: Center(child: Text('추천 테마')),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('일본 불꽃 축제', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 200,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       _buildRecommendationItem('도쿄 가츠시카 납량 불꽃놀이', 'assets/katsushika.jpg'),
//                       _buildRecommendationItem('도쿄 아다치 불꽃놀이', 'assets/adachi.jpg'),
//                       _buildRecommendationItem('오사카 비와코 불꽃축제', 'assets/biwa.jpg'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryItem(BuildContext context, String assetImagePath, String label, String subtitle, String image, String description) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AnimationDetailPage(
//               title: label,
//               subtitle: subtitle,
//               image: image,
//               description: description,
//             ),
//           ),
//         );
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipOval(
//             child: Image.asset(assetImagePath, width: 40, height: 40, fit: BoxFit.cover,),
//           ),
//           SizedBox(height: 5),
//           Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecommendationItem(String name, String assetImagePath) {
//     return Padding(
//       padding: EdgeInsets.only(right: 10.0),
//       child: Container(
//         width: 150,
//         color: Colors.grey[300],
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 100,
//                 color: Colors.grey[400],
//                 child: Image.asset(assetImagePath, fit: BoxFit.cover),
//               ),
//               SizedBox(height: 5),
//               Text(name, style: TextStyle(fontSize: 14)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RecommendTab extends StatefulWidget {
//   @override
//   _RecommendTabState createState() => _RecommendTabState();
// }

// class _RecommendTabState extends State<RecommendTab> {
//   List<Map<String, String>> destinations = [
//     {
//       'name': '스가신사',
//       'description': '너의 이름은에서 두 남녀가 만났던 장소',
//       'image': 'assets/kimino_rec.JPG'
//     },
//     {
//       'name': '가마쿠라코코마에역',
//       'description': '슬램덩크 오프닝 장면의 모티브가 된 장소',
//       'image': 'assets/slam_rec.JPG'
//     },
//     {
//       'name': '사야마 구릉',
//       'description': '토토로 숲의 모티브가 된 장소',
//       'image': 'assets/totoro_rec.JPG'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: destinations.map((destination) {
//           return Dismissible(
//             key: Key(destination['name']!),
//             onDismissed: (direction) {
//               String action;
//               if (direction == DismissDirection.endToStart) {
//                 Provider.of<FavoriteAndDeletedProvider>(context, listen: false)
//                     .addDeletedItem(destination['name']!);
//                 action = '삭제됨';
//               } else {
//                 Provider.of<FavoriteAndDeletedProvider>(context, listen: false)
//                     .addFavoriteItem(destination['name']!);
//                 action = '찜됨';
//               }

//               setState(() {
//                 destinations.remove(destination);
//               });

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('${destination['name']} $action'),
//                 ),
//               );
//             },
//             background: Container(
//               color: Colors.green,
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(Icons.favorite, color: Colors.white),
//             ),
//             secondaryBackground: Container(
//               color: Colors.red,
//               alignment: Alignment.centerRight,
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Icon(Icons.delete, color: Colors.white),
//             ),
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(destination['image']!),
//                     fit: BoxFit.cover,
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.3),
//                       BlendMode.darken,
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       destination['name']!,
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       destination['description']!,
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }