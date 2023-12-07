import 'package:crypto_test/views/widgets/coin_item_usdt.dart';
import 'package:crypto_test/views/widgets/colors.dart';
import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        child: ListView(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'wa3'.png,
                    height: 40,
                    width: 40,
                  ),
                ),
                Spacer(),
                Image.asset(
                  'btc'.png,
                  height: 24,
                  width: 24,
                ),
                Text(
                  'BTC / USDT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'wa4'.png,
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            Row(
              children: [
                Image.asset(
                  'wa5'.png,
                  height: 60,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3,839.65',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Image.asset('up'.png, height: 16),
                        Text(
                          '105 (%0.8)',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 13),
            Image.asset('graph1'.png),
            SizedBox(height: 32.63),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Buy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    height: 45,
                    width: 135,
                  ),
                ),
                SizedBox(width: 13),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.infrared,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Sell',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    height: 45,
                    width: 135,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Quick watch',
                  style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Text(
                  'See all',
                  style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.white38,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.separated(
                separatorBuilder: (_, __) => SizedBox(height: 10),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 6,
                itemBuilder: (_, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => CoinDetailsScreen()));
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: CoinItemUsdt(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
