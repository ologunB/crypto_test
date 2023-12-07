import 'package:crypto_test/views/home/coin_details.dart';
import 'package:crypto_test/views/widgets/coin_item_usdt.dart';
import 'package:crypto_test/views/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.onPrimary,
        title: Center(
          child: Text(
            'Markets',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 10),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: 12,
          itemBuilder: (_, i) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => CoinDetailsScreen()));
              },
              borderRadius: BorderRadius.circular(20),
              child: CoinItemUsdt(),
            );
          },
        ),
      ),
    );
  }
}
