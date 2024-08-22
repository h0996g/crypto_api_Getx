import 'package:crypto_api/controllers/assets_controller.dart';
import 'package:crypto_api/widgets/add_asset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final AssetsController assetsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(
          context,
        ),
        body: Column(
          children: [
            _portfolioValue(
              context,
            ),
          ],
        ));
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://i.pravatar.cc/150?img=2",
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.dialog(
              AddAssetDialog(),
            );
          },
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
      ),
      child: Center(
        child: GetX<AssetsController>(
          init: AssetsController(),
          initState: (_) {},
          builder: (_) {
            if (_.loading.value == true) {
              return const CircularProgressIndicator();
            }

            return Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  const TextSpan(
                    text: "\$",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "${_.getPortfolioValue().toStringAsFixed(2)}\n",
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(
                    text: "Portfolio value",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
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
}
