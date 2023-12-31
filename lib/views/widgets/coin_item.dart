import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/material.dart';

import '../../models/coin_model.dart';
import 'coin_icon.dart';
import 'colors.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({super.key, required this.coin});

  final Coin coin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff18181C),
      ),
      child: Row(
        children: [
          CoinIcon(coin.image, 50),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  coin.symbol,
                  style: TextStyle(
                    color: AppColors.text2,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Image.asset('graph'.png, height: 33),
          SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${coin.price.toString().toAmount()}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(coin.change24h.isNegative ? 'down'.png : 'up'.png,
                      height: 16),
                  SizedBox(width: 2),
                  Text(
                    '${coin.change24h.toString().toAmount()} (%24h)',
                    style: TextStyle(
                      color: AppColors.text2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
