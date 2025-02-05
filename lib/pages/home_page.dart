import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mabc2/pages/info_page.dart';
import 'package:mabc2/pages/instruction_page.dart';
import 'package:mabc2/pages/login_page.dart';
import 'package:mabc2/pages/test_page.dart';
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          elevation: 15,
          color: Colors.indigo,
          child: Container(
            height: 350,
            width: 250,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset('assets/images/sonic.png')),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TestPage()));
                },
                child: Text(
                  'Boshlash',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
        ),
      ]),
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
                      onTap:_pickImage,
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
                    Text('Dasturga xush kelibsiz ${widget.username}',style: TextStyle(color: Colors.white),),
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
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Dastur haqida'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InfoPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Chiqish'),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? refreshToken = prefs.getString('auth_token');
                if (refreshToken != null) {
                  print('Token $refreshToken');
                  context.read<TestViewModel>().logOut(refreshToken);
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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
