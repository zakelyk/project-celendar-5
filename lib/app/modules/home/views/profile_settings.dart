//modul 4

import 'package:celendar/app/modules/home/controllers/auth_controller.dart';
import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:celendar/app/modules/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final AuthController _authController = Get.put(AuthController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String userId = '';

  @override

  void initState() {
    super.initState();
    // Mendapatkan data pengguna saat widget diinisialisasi
    _loadUserData();
  }

  void _loadUserData() async {
    final userDataList = _authController.userData.value;
    if (userDataList != null && userDataList.isNotEmpty) {
      final userData = userDataList.first; // Assuming you want the first item from the list
      setState(() {
        _emailController.text = userData['email'] ?? '';
        _usernameController.text = userData['username'] ?? '';
        userId = userData['\$id'];
      });
    }
  }


  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    // Kembali ke halaman sebelumnya
                    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                    Navigator.pop(context);
                  },
                ),
                // Menambahkan icon titik tiga di pojok kanan atas
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Menampilkan informasi user
                Text(
                  "User Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                ListTile(
                  title: Text("Username : "),
                  subtitle: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "Enter your username",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Tombol untuk logout
                ElevatedButton(
                  onPressed: () {
                    // Melakukan logout
                    // _databaseController.updateUserData(context, userId, {"username":_usernameController.text});
                    // Kembali ke halaman login

                  },
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
