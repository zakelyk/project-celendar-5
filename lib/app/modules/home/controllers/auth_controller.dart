
import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:celendar/app/modules/home/views/login.dart';
import 'package:celendar/app/modules/home/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();
  String dokumenId ='';
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  RxList<Map<String, dynamic>> userData = <Map<String, dynamic>>[].obs; // Inisialisasi userData

  @override
  void onInit(){
    print("On INIT");
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async{
    isLoggedIn.value = _prefs.containsKey("user_token");
    print("check login status : ${isLoggedIn.value}");
  }

  Future<void> signUp(String userMail, String userPass) async {
    try{
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(email: userMail, password: userPass);
      Get.snackbar("SignUp Success", "Registration Successful", backgroundColor: Colors.blue);
      Get.off(LoginPage());
    }catch(error){
      Get.snackbar("Error", "Registration Failed!! : $error", backgroundColor: Colors.red);
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> logIn(String email, String password) async{
    try{
      isLoading.value=true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Login Successful", "Loging in....",backgroundColor: Colors.blue);
      isLoggedIn.value = true;

      final data = await _databaseController.getLoginData(email);
      print("data in getLoginData: $data");
      userData.assignAll(data ?? <Map<String, dynamic>>[]);
      print("userData : $userData");
      dokumenId = userData.first['\$id'];
      print("dokumen Id : $dokumenId");
      Get.off(ProfilePage());
    }catch(error){
      Get.snackbar("Error", "Login failed : $error", backgroundColor: Colors.red);
    }finally{
      isLoading.value = false;
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // await _auth.
        // await currentUser.delete();
        await FirebaseAuth.instance.currentUser!.delete();
        isLoggedIn.value = false;
        userData.assignAll([]);
        _databaseController.deleteUserData(dokumenId);
        Get.offAll(LoginPage());
      }
    } catch (error) {
      Get.snackbar("Error", "Failed to delete account: $error", backgroundColor: Colors.red);
    }
  }

  void logOut() async{
    await _auth.signOut();
    isLoggedIn.value = false;
    // userData.assignAll([]);
    Get.offAll(LoginPage());
    // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }


}