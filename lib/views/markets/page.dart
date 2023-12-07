import 'package:crypto_test/views/widgets/coin_item_usdt.dart';
import 'package:flutter/material.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        separatorBuilder: (_, __) => SizedBox(height: 10),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (_, i) {
          return CoinItemUsdt();
        },
      ),
    );
  }
}
