import 'package:crypto_test/views/widgets/colors.dart';
import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/coin_item.dart';
import 'coin_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                children: [
                  Image.asset('person'.png, height: 42, width: 42),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(color: AppColors.text1, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'John',
                        style: TextStyle(
                          color: AppColors.text1,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'wa0'.png,
                      height: 42,
                      width: 41,
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: Image.asset('wa1'.png, height: 42, width: 41),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: AppColors.primary,
                    hintText: 'Search...',
                    hintStyle: TextStyle(fontSize: 16, color: AppColors.text2),
                    filled: true,
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('search'.png, height: 24, width: 24),
                      ],
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('wa2'.png, height: 42, width: 42),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff585866),
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('wa-bg'.png), fit: BoxFit.fitWidth),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Text(
                  'Portfolio value ',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  '\$47,412.65',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Image.asset('up'.png, height: 16),
                    Text(
                      '\$453.85(+1.6%)',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    Spacer(),
                    Image.asset('graph'.png, height: 35),
                  ],
                ),
                SizedBox(height: 17),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.white38,
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(color: Colors.white38, fontSize: 14),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.white38,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Watchlist',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 16),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: 6,
          itemBuilder: (_, i) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => CoinDetailsScreen()));
              },
              borderRadius: BorderRadius.circular(20),
              child: CoinItem(),
            );
          },
        ),
      ],
    );
  }
}
