import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String nickname = "바보";
  String name = "방은서";
  String email = "eunseo2715@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 60),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // 프로필 사진 변경 코드
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('사진 변경'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('닉네임'),
                subtitle: Text(nickname),
                trailing: Icon(Icons.edit),
                onTap: () {
                  _editDialog('닉네임', nickname, (value) {
                    setState(() {
                      nickname = value;
                    });
                  });
                },
              ),
              ListTile(
                title: Text('이름'),
                subtitle: Text(name),
                trailing: Icon(Icons.edit),
                onTap: () {
                  _editDialog('이름', name, (value) {
                    setState(() {
                      name = value;
                    });
                  });
                },
              ),
              ListTile(
                title: Text('이메일'),
                subtitle: Text(email),
                trailing: Icon(Icons.edit),
                onTap: () {
                  _editDialog('이메일', email, (value) {
                    setState(() {
                      email = value;
                    });
                  });
                },
              ),
              ListTile(
                title: Text('비밀번호 변경'),
                trailing: Icon(Icons.edit),
                onTap: () {
                  _editDialog('비밀번호 변경', '', (value) {
                    // 비밀번호 변경 로직을 여기에 추가하세요.
                  });
                },
              ),
              ListTile(
                title: Text('휴대폰 번호 변경'),
                trailing: Icon(Icons.edit),
                onTap: () {
                  _editDialog('휴대폰 번호 변경', '', (value) {
                    // 휴대폰 번호 변경 로직을 여기에 추가하세요.
                  });
                },
              ),
              Divider(),
              ListTile(
                title: Text('찜'),
                leading: Icon(Icons.favorite),
                onTap: () {
                  // 찜으로 이동하는 코드
                },
              ),
              ListTile(
                title: Text('삭제'),
                leading: Icon(Icons.delete),
                onTap: () {
                  // 삭제으로 이동하는 코드
                },
              ),
              ListTile(
                title: Text('내 활동'),
                leading: Icon(Icons.list_alt_sharp),
                onTap: () {
                  // 내 활동으로 이동하는 코드
                },
              ),
              ListTile(
                title: Text('알림'),
                leading: Icon(Icons.notifications),
                onTap: () {
                  // 알림으로 이동하는 코드
                },
              ),
              ListTile(
                title: Text('테마 설정'),
                leading: Icon(Icons.settings_display),
                onTap: () {
                  // 테마 설정으로 이동하는 코드
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editDialog(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
          ],
        );
      },
    );
  }
}
