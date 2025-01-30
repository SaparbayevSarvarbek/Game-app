import 'package:flutter/material.dart';
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
      appBar: AppBar(
        toolbarHeight: 160,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Center(child: Text('Bepul test ishlang',style: TextStyle(fontSize: 24,color: Colors.white),)),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 15,
              color: Colors.indigo,
              child: Container(
                height: 350,
                width: 250,
                child: Padding(padding: EdgeInsets.all(15),child: Image.asset('assets/images/sonic.png')),
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
    );
  }
}
