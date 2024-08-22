import 'package:crypto_api/controllers/assets_controller.dart';
import 'package:crypto_api/services/http_service.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  // Register services
  Get.put(HTTPService());
}

Future<void> registerControllers() async {
  // Register controllers
  Get.put(AssetsController());
}
