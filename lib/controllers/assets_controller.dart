import 'package:crypto_api/models/tracked_asset.dart';
import 'package:get/get.dart';

class AssetController extends GetxController {
  RxList<TrackedAsset> trackAssets = <TrackedAsset>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  void addAsset({required String name, required double amount}) {
    trackAssets.add(TrackedAsset(name: name, amount: amount));
    print(trackAssets);
  }
}
