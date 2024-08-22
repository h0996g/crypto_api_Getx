import 'package:crypto_api/controllers/assets_controller.dart';
import 'package:crypto_api/models/tracked_asset.dart';
import 'package:crypto_api/pages/details_page.dart';
import 'package:crypto_api/util.dart';
import 'package:crypto_api/widgets/add_asset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: Column(
        children: [
          _portfolioValue(context),
          _trackedAssetsList(context),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.dialog(AddAssetDialog());
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text("Crypto Portfolio"),
      centerTitle: true,
      leading: const CircleAvatar(
        backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=2"),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(AddAssetDialog());
          },
          icon: const Icon(Icons.add),
        )
      ],
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      child: Center(
        child: GetX<AssetsController>(
          init: AssetsController(),
          builder: (_) {
            if (_.loading.value == true) {
              return const CircularProgressIndicator(color: Colors.white);
            }

            return Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  const TextSpan(
                    text: "\$",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "${_.getPortfolioValue().toStringAsFixed(2)}\n",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(
                    text: "Portfolio Value",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _trackedAssetsList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tracked Assets",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            GetX<AssetsController>(
              builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _.trackedAssets.length,
                    itemBuilder: (context, index) {
                      TrackedAsset trackedAsset = _.trackedAssets[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Image.network(
                            getCryptoImageURL(trackedAsset.name!),
                          ),
                          title: Text(
                            trackedAsset.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "USD: ${_.getAssetPrice(trackedAsset.name!).toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Text(
                            trackedAsset.amount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Get.to(() {
                              return DetailsPage(
                                coin: _.getCoinData(trackedAsset.name!)!,
                              );
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
