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
      body: Consumer<TestViewModel>(builder: (context, myProvider, child) {
        if (myProvider.isLoading) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                spacing: 16,
                children: [
                  CircularProgressIndicator(),
                  const Text('Yuklanmoqda')
                ]),
          );
        } else {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: myProvider.question.length,
              itemBuilder: (context, index) {
                final category = myProvider.question[index];
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestPage(
                                    questionList: category.questionList,
                                  )));
                    },
                    title: Text(
                      category.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
