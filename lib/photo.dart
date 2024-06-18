import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUploadPage extends StatefulWidget {
  final Map<String, dynamic> board;

  PhotoUploadPage({required this.board});

  @override
  _PhotoUploadPageState createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _uploadedImages = [];
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // "너의 이름은" 게시판에 예시 댓글 추가
    if (widget.board['title'] == '너의 이름은') {
      _uploadedImages.add({
        'file': 'assets/kimino_ex.jpeg', // 예시 이미지 경로를 문자열로 저장
        'description': '구도 완전 똑같죠?'
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _uploadComment() {
    if (_selectedImage != null && _descriptionController.text.isNotEmpty) {
      setState(() {
        _uploadedImages.add({
          'file': _selectedImage,
          'description': _descriptionController.text,
        });
        _descriptionController.clear();
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.board['title']),
      ),
      body: Column(
        children: [
          // 게시판별 이미지
          Image.asset(
            widget.board['image'],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          // 설명 입력 필드
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '사진에 대해 간단한 이야기를 남겨주세요',
              ),
            ),
          ),
          SizedBox(height: 20),
          // 사진 업로드 버튼 (좌측 정렬)
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload Photo'),
            ),
          ),
          // 올리기 버튼 (하단)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _uploadComment,
              child: Text('올리기'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 36),
              ),
            ),
          ),
          SizedBox(height: 20),
          // 다른 사람들이 올린 사진 목록
          Expanded(
            child: ListView.builder(
              itemCount: _uploadedImages.length,
              itemBuilder: (context, index) {
                var imageFile = _uploadedImages[index]['file'];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_uploadedImages[index]['description']),
                      SizedBox(height: 8),
                      imageFile is String
                          ? Image.asset(
                              imageFile,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              imageFile,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
