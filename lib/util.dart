import 'package:crypto_api/services/http_service.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  // Register services
  Get.put(HTTPService());
}
