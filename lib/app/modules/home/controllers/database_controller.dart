//modul 5
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'client_controller.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
// appwrite
    databases = Databases(client);
  }



  Future storeNewUserData(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "6571e69ab20f6ef02e03",
        documentId: ID.unique(),
        collectionId: "6571e721efbca96226b6",
        data: map,
        permissions: [
          Permission.update(Role.guests()),
          Permission.read(Role.guests()),
        ],
      );
      print("DatabaseController:: storeUserName $databases");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }


  Future<List<Map<String, dynamic>>?> getLoginData(String email) async {
    try {
      final result = await databases!.listDocuments(
        databaseId: "6571e69ab20f6ef02e03",
        collectionId: "6571e721efbca96226b6",
        queries: [Query.equal("email", email)],

      );
      List<Map<String, dynamic>>? loginData = result.documents?.map((doc) => doc.data).toList();
      List<Document> documents = result.documents;
      documents.forEach((document) {
        print(document.data); // Ini adalah data dari setiap dokumen
      });
      print("email: ${documents.first.data['email']}");
      print("username: ${documents.first.data['username']}");
      print("result : ${result}");
      print("Documents: ${result.documents}");
      print("DatabaseController:: storeUserName $databases");
      return loginData;
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future deleteUserData(String docId) async {
    try {
      final target = await databases!.deleteDocument(databaseId: "6571e69ab20f6ef02e03", collectionId: "6571e721efbca96226b6", documentId: docId);
      print("DatabaseController:: deleteUser $databases");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}