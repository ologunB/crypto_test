import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CoinItem extends StatelessWidget {
  const CoinItem({super.key});

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
          Image.asset('coin'.png, height: 50, width: 50),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bitcoin',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                'BTC',
                style: TextStyle(
                  color: AppColors.text2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Spacer(),
          Image.asset('graph'.png, height: 33),
          SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$47,412.65',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Image.asset('up'.png, height: 16),
                  SizedBox(width: 2),
                  Text(
                    '+1.6%',
                    style: TextStyle(
                      color: AppColors.text2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
