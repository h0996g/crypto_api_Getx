import 'package:crypto_api/controllers/assets_controller.dart';
import 'package:crypto_api/models/api_response.dart';
import 'package:crypto_api/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssetDialogController extends GetxController {
  RxBool loading = true.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAsset = "".obs;
  RxDouble assetValue = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    getAssets();
  }

  Future<void> getAssets() async {
    loading.value = true;
    HTTPService httpService = Get.find<HTTPService>();
    var responseDate = await httpService.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responseDate);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
    });
    print(assets);
    selectedAsset.value = assets.first;
    loading.value = false;
  }
}

class AddAssetDialog extends StatelessWidget {
  AddAssetDialog({super.key});
  final AddAssetDialogController dialogController =
      Get.put(AddAssetDialogController());
  @override
  Widget build(BuildContext context) {
    return GetX<AddAssetDialogController>(
      builder: (DisposableInterface controller) {
        return Center(
          child: Material(
            child: Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildUi(context, dialogController)),
          ),
        );
      },
    );
  }

  Widget _buildUi(BuildContext context, AddAssetDialogController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: controller.loading.isTrue
            ? const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Select Asset",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: controller.selectedAsset.value,
                    items: controller.assets.map((element) {
                      return DropdownMenuItem(
                        value: element,
                        child: Text(
                          element,
                          overflow: TextOverflow
                              .ellipsis, // Ensures long text doesn't overflow
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedAsset.value = value.toString();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    isExpanded:
                        true, // Ensures dropdown takes full available width
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      controller.assetValue.value = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Asset Value",
                      labelStyle: TextStyle(color: Colors.grey[600]),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.find<AssetsController>().addTrackedAsset(
                        name: controller.selectedAsset.value,
                        amount: controller.assetValue.value,
                      );
                      Get.back(closeOverlays: true);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Add Asset",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
