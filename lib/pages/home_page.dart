import 'package:flutter/material.dart';
import 'package:mabc2/pages/info_page.dart';
import 'package:mabc2/pages/instruction_page.dart';
import 'package:mabc2/pages/login_page.dart';
import 'package:mabc2/pages/test_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: const Text('Navigatsiya paneli'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Asosiy sahifa'),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Yo\'riqnoma'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InstructionPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Dastur haqida'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Chiqish'),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}