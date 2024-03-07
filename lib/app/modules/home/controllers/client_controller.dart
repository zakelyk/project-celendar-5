//modul 5

import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

class ClientController extends GetxController {
  Client client = Client();
  @override
  void onInit() {
    super.onInit();
// appwrite
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "6571cc3a5f60fe4d0d04";
    client.setEndpoint(endPoint).setProject(projectID).setSelfSigned(status: true);
  }
}