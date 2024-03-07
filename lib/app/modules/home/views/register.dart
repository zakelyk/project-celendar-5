//modul 4

import 'package:celendar/app/modules/home/controllers/auth_controller.dart';
import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final AuthController _authController = Get.put(AuthController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();


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
          child: IconButton(icon: Icon(Icons.arrow_back_ios_rounded),onPressed: (){Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);},),),
        Padding(padding: EdgeInsets.only(top: 80),
          child: Center(child:Text("Register", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),),
        Padding(padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.mail_outline),),controller: _emailController,),
            SizedBox(height:20 ,),
            TextField(decoration: InputDecoration(labelText: "Username", prefixIcon: Icon(Icons.person),),controller: _usernameController,),
            SizedBox(height:20 ,),
            TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.key),),controller: _passwordController,),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              TextButton(onPressed:(){Navigator.of(context).pop();},child:Padding(padding: EdgeInsets.only(left: 16), child: Text("Already have an account?", style: TextStyle(color: Colors.blue, fontSize: 16),),),),
              Padding(padding: EdgeInsets.only(right: 16),child: ElevatedButton(onPressed:
              _authController.isLoading.value ? null :(){
                _authController.signUp(_emailController.text, _passwordController.text);
                _databaseController.storeNewUserData({"email":_emailController.text,"username":_usernameController.text});
              },child: Text("Register"),),)
            ],)
          ],),),
      ],
      ),
    );
  }
}