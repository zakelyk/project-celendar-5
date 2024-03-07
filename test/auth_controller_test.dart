import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:celendar/app/modules/home/controllers/auth_controller.dart';

void main() {
  group('AuthController Tests', () {
    late AuthController authController;

    setUp(() {
      Get.testMode = true; // Mengaktifkan mode pengujian GetX
      authController = AuthController();
    });

    test('SignUp Test', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';

      // Act
      await authController.signUp(email, password);

      // Assert
      expect(authController.isLoading.value, false);
      // Add assertions based on your specific logic in signUp function
    });

    test('LogIn Test', () async {
      // Arrange
      final email = 'test@example.com';
      final password = 'password123';

      // Act
      await authController.logIn(email, password);

      // Assert
      expect(authController.isLoading.value, false);
      expect(authController.isLoggedIn.value, true);
      // Add assertions based on your specific logic in logIn function
    });

    test('DeleteAccount Test', () async {
      // Arrange
      // Set up a logged-in state (simulate a logged-in user)
      authController.isLoggedIn.value = true;

      // Act
      await authController.deleteAccount();

      // Assert
      expect(authController.isLoggedIn.value, false);
      // Add assertions based on your specific logic in deleteAccount function
    });

    test('LogOut Test', () async {
      // Arrange
      // Set up a logged-in state (simulate a logged-in user)
      authController.isLoggedIn.value = true;

      // Act
      authController.logOut();

      // Assert
      expect(authController.isLoggedIn.value, false);
      // Add assertions based on your specific logic in logOut function
    });

    tearDown(() {
      Get.reset(); // Me-reset status GetX setelah setiap tes
    });
  });
}
