import 'package:crypto_test/views/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/coin/coin_bloc.dart';
import '../home/coin_details.dart';
import '../widgets/coin_item_usdt.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  Widget build(_) {
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
      body: BlocBuilder<CoinBloc, CoinState>(builder: (_, state) {
        if (state is CoinLoadingState) {
          return ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: 6,
            itemBuilder: (_, i) {
              return SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white38,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      height: 100.0,
                      color: Colors.white38,
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is CoinLoadedState) {
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(
              height: 0,
              color: Colors.grey,
              thickness: .5,
            ),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: state.coins.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => CoinDetailsScreen(coin: state.coins[i]),
                    ),
                  );
                },
                child: CoinItemUsdt(coin: state.coins[i]),
              );
            },
          );
        } else if (state is CoinErrorState) {
          return Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Text(
              state.error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return SizedBox();
      }),
    );
  }
}
