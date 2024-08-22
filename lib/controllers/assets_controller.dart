import 'dart:convert';

import 'package:crypto_api/models/api_response.dart';
import 'package:crypto_api/models/coin_data.dart';
import 'package:crypto_api/services/http_service.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tracked_asset.dart';

class AssetsController extends GetxController {
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;
  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
    _loadTrackedAssetsFromStorage();
  }

  Future<void> _getAssets() async {
    loading.value = true;

    HTTPService httpService = Get.find();
    var responseData = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(
      responseData,
    );
    coinData.value = currenciesListAPIResponse.data ?? [];
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('tracked_assets');
  }

  void addTrackedAsset({required String name, required double amount}) async {
    trackedAssets.add(
      TrackedAsset(
        name: name,
        amount: amount,
      ),
    );
    List<String> data =
        trackedAssets.map((asset) => jsonEncode(asset)).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      "tracked_assets",
      data,
    );
  }

  void _loadTrackedAssetsFromStorage() async {
    // loading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tracked_assets");
    if (data != null) {
      trackedAssets.value = data
          .map(
            (e) => TrackedAsset.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
    }
    loading.value = false;

    print(trackedAssets);
  }

  double getPortfolioValue() {
    if (coinData.isEmpty) {
      return 0;
    }
    if (trackedAssets.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((e) => e.name == name);
  }
}
