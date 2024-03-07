//modul 4

import 'package:celendar/app/modules/home/controllers/auth_controller.dart';
import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:celendar/app/modules/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authController = Get.put(AuthController());
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
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return {'Edit Profile', 'Delete Profile'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  onSelected: (String choice) {
                    // Menghandle pemilihan opsi dari menu titik tiga
                    if (choice == 'Edit Profile') {
                      Get.toNamed('/setings');
                      // Tambahkan aksi ketika "Edit Profile" dipilih
                      // Misalnya, pindah ke halaman edit profil
                      print('Edit Profile');
                    } else if (choice == 'Delete Profile') {
                      _authController.deleteAccount();
                      // Tambahkan aksi ketika "Delete Profile" dipilih
                      // Misalnya, munculkan dialog konfirmasi penghapusan profil
                      print('Delete Profile');
                    }
                  },
                ),
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
                // Menampilkan email user
                ListTile(
                  title: Text("Email : "),
                  subtitle: Text(_emailController.text),
                ),
                SizedBox(height: 20),
                // Menampilkan username user
                ListTile(
                  title: Text("Username : "),
                  subtitle: Text(_usernameController.text),
                ),
                SizedBox(height: 20),
                // Tombol untuk logout
                ElevatedButton(
                  onPressed: () {
                    // Melakukan logout
                    _authController.logOut();
                    // Kembali ke halaman login

                  },
                  child: Text("Logout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
