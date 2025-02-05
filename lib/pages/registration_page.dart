import 'package:flutter/material.dart';
import 'package:mabc2/moduls/username_model.dart';
import 'package:mabc2/pages/home_page.dart';
import 'package:mabc2/view_model/registration_view_model.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Foydalanuvchi nomi',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Foydalanuvchi nomini kirting';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Elektron pochta', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Elektron pochtani kirting';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                      .hasMatch(value)) {
                    return 'Email formati noto\'g\'ri';
                  }
                  return null;
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
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _password2Controller,
                decoration: InputDecoration(
                    labelText: 'Parolni takror kirting',
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Parolni takror kirting';
                  }
                  if (_password2Controller.text != _passwordController.text) {
                    return 'Parol mos kelmadi';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        UsernameModel usernameModel=UsernameModel(username: _nameController.text, email: _emailController.text, password: _passwordController.text, password2: _password2Controller.text);
                        context.read<RegistrationViewModel>().addUser(usernameModel);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(username:_nameController.text,)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    child: Text(
                      'Ro\'yhatdan o\'tish',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Akkountingiz bo\'rmi unda  '),
                  InkWell(onTap: (){
                  Navigator.pop(context);
                    },child: Text('Kirish',style: TextStyle(color: Colors.indigo),)),
                ],
              )
            ],
          )),
    ));
  }
}