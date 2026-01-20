import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mabc2/pages/registration_page.dart';
import 'package:mabc2/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Consumer<LoginViewModel>(builder: (context, provider, child) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dasturga xush kelibsiz',
                    style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_sharp,color:Colors.indigo),
                        labelText: 'Username',
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username kiriting';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        labelText: 'Parol',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock,color: Colors.indigo,),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.indigo,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Parolni kirting';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    width: provider.isLoading
                        ? 40.w
                        : MediaQuery.of(context).size.width,
                    height: provider.isLoading ? 40.w : 50.h,
                    child: provider.isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                            ),
                            onPressed: () async {
                              final viewModel= context.read<LoginViewModel>();
                              bool isConnected = await checkInternet();
                              if (isConnected) {
                                if (_formKey.currentState!.validate()) {
                                  viewModel.loginUser(
                                      _nameController.text,
                                      _passwordController.text,
                                      context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Internet mavjud emas")),
                                );
                              }
                            },
                            child: Text(
                              'Internet mavjud emas',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18.sp),
                            )),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Akkauntingiz yoqmi?  '),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationPage()));
                          },
                          child: Text(
                            'Ro\'yhatdan o\'tish',
                            style: TextStyle(color: Colors.indigo),
                          )),
                    ],
                  )
                ],
              ),
            );
          })),
    );
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
