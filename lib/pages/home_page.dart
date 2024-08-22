import 'package:crypto_api/widgets/add_asset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(
          context,
        ),
        body: const Text(
          'hi',
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
              const AddAssetDialog(),
            );
          },
          icon: const Icon(
            Icons.add,
          ),
        )
      ],
    );
  }
}
