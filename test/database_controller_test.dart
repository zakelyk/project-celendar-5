import 'dart:html';

import 'package:celendar/app/modules/home/controllers/database_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:appwrite/appwrite.dart';

class MockDatabases extends Mock implements Databases {}

final dummyUserData = {
  'username': 'john_doe',
  'email': 'john.doe@example.com',
  // tambahkan kunci dan nilai lain sesuai kebutuhan Anda
};

final mockDatabases = MockDatabases();

class MockDocument extends Mock implements Document {

}


void main() {
  late DatabaseController databaseController;
  late MockDatabases mockDatabases;

  setUp(() {
    mockDatabases = MockDatabases();
    databaseController = DatabaseController();
    databaseController.databases = mockDatabases;
  });

  test('Test Store New User Data', () async {
    // Mock data untuk tes
    final mockUserData = {
      'username': 'testuser',
      'email': 'test@example.com',
    };

    // Mock panggilan metode createDocument
    when(mockDatabases.createDocument(
      databaseId: "6571e69ab20f6ef02e03",
      documentId: "6573122132289b4e56ec",
      collectionId: "6571e721efbca96226b6",
      data: dummyUserData,
      permissions: [
        Permission.update(Role.guests()),
        Permission.read(Role.guests()),
        Permission.delete(Role.guests()),
      ],
    ));

    // Jalankan metode yang diuji
    await databaseController.storeNewUserData(mockUserData);

    // Verifikasi bahwa metode createDocument telah dipanggil dengan parameter yang benar
    verify(mockDatabases.createDocument(
      databaseId: "6571e69ab20f6ef02e03",
      documentId: "6573122132289b4e56ec",
      collectionId: "6571e721efbca96226b6",
      data: dummyUserData,
      permissions: [
        Permission.update(Role.guests()),
        Permission.read(Role.guests()),
        Permission.delete(Role.guests()),
      ],
    )).called(1);
  });

  // Tambahkan unit test lainnya sesuai kebutuhan Anda
}
