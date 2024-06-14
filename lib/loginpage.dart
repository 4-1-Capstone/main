import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50),
              Column(
                children: [
                  Image.asset('assets/anigation.png', height: 200),
                  SizedBox(height: 20),
                  Text(
                    'Ani_gation',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '애니메이션 여행지는 여기서!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: 'Ani_gation')),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[800],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                          fixedSize: Size(170, 50), // 버튼 크기 고정
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // 버튼 각지게 설정
                          ),
                        ),
                        child: Text('게스트로 시작'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // 로그인 버튼 클릭 시 동작
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: 'Ani_gation')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[800],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          textStyle: TextStyle(fontSize: 16),
                          fixedSize: Size(170, 50), // 버튼 크기 고정
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // 버튼 각지게 설정
                          ),
                        ),
                        child: Text('로그인'),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // 가입하기 버튼 클릭 시 동작
                    },
                    child: Text(
                      '가입하기',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
