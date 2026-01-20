import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 18.sp),
                    child: Text('Ro\'yhatdan o\'tish',
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold))),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.indigo,
                      ),
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
                  height: 20.h,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_sharp, color: Colors.indigo),
                      labelText: 'Elektron pochta',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Elektron pochtani kirting';
                    }
                    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+\w{2,4}$')
                        .hasMatch(value)) {
                      return 'Email formati noto\'g\'ri';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  obscureText: _obscureText1,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.indigo,
                      ),
                      labelText: 'Parol',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.indigo,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      ),
                      border: OutlineInputBorder()),
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
                  obscureText: _obscureText2,
                  controller: _password2Controller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.indigo,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.indigo,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
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
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          UsernameModel usernameModel = UsernameModel(
                              username: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              password2: _password2Controller.text);
                          context
                              .read<RegistrationViewModel>()
                              .addUser(usernameModel);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        username: _nameController.text,
                                      )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      child: Text(
                        'Ro\'yhatdan o\'tish',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Akkountingiz bormi  '),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Kirish',
                          style: TextStyle(color: Colors.indigo),
                        )),
                  ],
                )
              ],
            )),
      ),
    ));
  }
}
