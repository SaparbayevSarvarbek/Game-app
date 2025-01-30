import 'package:flutter/material.dart';
import 'package:mabc2/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dasturga xush kelibsiz',style: TextStyle(fontSize: 24),),
              SizedBox(height: 40,),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Ism', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ismingni kiriting';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Parol', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Parolni kirting';
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6D5ED2),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      }
                    },
                    child: Text(
                      'Kirish',
                      style: TextStyle(color: Colors.white,fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
