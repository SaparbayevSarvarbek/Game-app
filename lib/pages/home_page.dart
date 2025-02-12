import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabc2/pages/instruction_page.dart';
import 'package:mabc2/pages/login_page.dart';
import 'package:mabc2/pages/test_page.dart';
import 'package:mabc2/view_model/login_view_model.dart';
import 'package:mabc2/view_model/test_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  String username;

  HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  @override
  void initState() {
    super.initState();
    context.read<TestViewModel>().getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('Asosiy sahifa'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Bolalar harakatni baholash testi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset('assets/images/home.jpg')),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Test haqida umumiy ma\'lumot:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              Text(
                '• Bolalarning harakatni baholash testi',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '• Bolalarning rivojlanishdagi kechikish yoki buzilishini aniqlash',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '• Testda beriladigan mashqlar',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • Qo‘l chaqqonligi',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • Nishonga otish va tutib olish',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • Muvozanat mashqlari',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '• Har bir yosh guruhiga 10 ta topshiriq',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '• Yosh oralig‘i 3 yosh – 16 yosh 11 oy',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • 3:0 – 6:11',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • 7:0 – 10:11',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              Text(
                '    • 11:0 – 16:11',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white),
                  child: Text('Testni boshlash'),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: Colors.indigo),
                child: Column(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(Icons.add_a_photo,
                                size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                    Text(
                      'Dasturga xush kelibsiz ${widget.username}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Asosiy sahifa'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Yo\'riqnoma'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InstructionPage()));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.info),
            //   title: const Text('Dastur haqida'),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => InfoPage()));
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Chiqish'),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? refreshToken = prefs.getString('auth_token');
                if (refreshToken != null) {
                  context.read<LoginViewModel>().logOut(refreshToken);
                } else {
                  print("Token topilmadi");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
