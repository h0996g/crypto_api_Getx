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

  final controller = Get.put(AddAssetDialogController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Material(
          child: Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildUi(context)),
        ),
      );
    });
  }

  Widget _buildUi(context) {
    if (controller.loading.isTrue) {
      return const Center(
        child:
            SizedBox(height: 30, width: 30, child: CircularProgressIndicator()),
      );
    } else {
      return Column(
        children: [
          DropdownButton(
              value: controller.selectedAsset.value,
              items: controller.assets.map(
                (element) {
                  return DropdownMenuItem(
                    value: element,
                    child: Text(element),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedAsset.value = value.toString();
                }
              }),
          TextField(
            onChanged: (value) {
              controller.assetValue.value = double.parse(value);
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          )
        ],
      );
    }
  }
}
