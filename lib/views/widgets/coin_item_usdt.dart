import 'package:crypto_test/blocs/watchlist/watch_bloc.dart';
import 'package:crypto_test/views/widgets/coin_icon.dart';
import 'package:crypto_test/views/widgets/colors.dart';
import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/coin_model.dart';

class CoinItemUsdt extends StatelessWidget {
  const CoinItemUsdt({super.key, required this.coin});

  final Coin coin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
          SizedBox(width: 24),
          BlocBuilder<WatchBloc, List<String>>(builder: (context, state) {
            return InkWell(
              onTap: () {
                context.read<WatchBloc>().add(AddCoinEvent(coin.id));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  color: state.contains(coin.id) ? Colors.green : Colors.grey,
                  child: Icon(state.contains(coin.id)
                      ? Icons.check
                      : Icons.add_rounded),
                  height: 40,
                  width: 40,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
