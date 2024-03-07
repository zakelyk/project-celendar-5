//modul 4

import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final AuthController _authController = Get.put(AuthController());
  // final DatabaseController _databaseController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(padding: EdgeInsets.only(top: 50),
          child: IconButton(icon: Icon(Icons.arrow_back_ios_rounded),onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);},),),
        Padding(padding: EdgeInsets.only(top: 80),
          child: Center(child:Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),),
        Padding(padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.mail_outline),), controller: _emailController,),
            SizedBox(height:20 ,),
            TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.key),),controller: _passwordController,),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              GestureDetector(onTap:(){Get.toNamed('/register');},child:Padding(padding: EdgeInsets.only(left: 16), child: Text("Register", style: TextStyle(color: Colors.blue, fontSize: 16),),)),
              Padding(padding: EdgeInsets.only(right: 16),child: ElevatedButton(onPressed: _authController.isLoading.value ? null :(){_authController.logIn(_emailController.text, _passwordController.text);},child: Text("Login"),),)
            ],)
          ],),),
      ],
      ),
    );
  }
}