import 'package:crypto_api/models/coin_data.dart';
import 'package:crypto_api/util.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final CoinData coin;

  const DetailsPage({
    super.key,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        coin.name!,
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _assetPrice(context),
            const SizedBox(height: 20),
            _assetInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _assetPrice(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            getCryptoImageURL(coin.name!),
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "\$ ${coin.values?.uSD?.price?.toStringAsFixed(2)}\n",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text:
                      "${coin.values?.uSD?.percentChange24h?.toStringAsFixed(2)} %",
                  style: TextStyle(
                    fontSize: 16,
                    color: coin.values!.uSD!.percentChange24h! > 0
                        ? Colors.greenAccent
                        : Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _infoCard("Circulating Supply", coin.circulatingSupply.toString()),
          _infoCard("Maximum Supply", coin.maxSupply.toString()),
          _infoCard("Total Supply", coin.totalSupply.toString()),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
