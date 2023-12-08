import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_test/views/widgets/colors.dart';
import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/candle/candle_bloc.dart';
import '../../models/coin_model.dart';
import '../widgets/coin_icon.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key, required this.coin});
  final Coin coin;

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  final intervals = [
    "1m",
    '5m',
    '30m',
    '1h',
    '6h',
    '12h',
    '1d',
    '1w',
    '1M',
  ];
  String interval = '1m';
  @override
  void initState() {
    context.read<CandleBloc>().add(FetchCandlesEvent(widget.coin.id, interval));
    super.initState();
  }

  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocBuilder<CandleBloc, CandleState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('wa3'.png, height: 40, width: 40),
                  ),
                  Spacer(),
                  CoinIcon(widget.coin.image, 24),
                  SizedBox(width: 6),
                  Text(
                    '${widget.coin.symbol} / USDT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Image.asset('wa4'.png, height: 40, width: 40),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 28),
              Row(
                children: [
                  SizedBox(width: 16),
                  Image.asset('wa5'.png, height: 60),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state is CandleLoadedState
                            ? '\$${state.candles.first.high.toString().toAmount()}'
                            : '\$${widget.coin.price.toString().toAmount()}',
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
                            '${widget.coin.change24h.toString().toAmount()} (%24hr)',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 13),
              if (state is CandleLoadingState)
                Container(
                  height: 400,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              if (state is CandleLoadedState)
                Container(
                  height: 400,
                  child: Theme(
                    data: ThemeData.dark(),
                    child: Builder(builder: (context) {
                      print('data: ${state.candles.first.high}');
                      return Candlesticks(
                          key: Key(widget.coin.id + interval),
                          candles: state.candles,
                          onLoadMoreCandles: () {
                            context.read<CandleBloc>().add(
                                LoadMoreCandlesEvent(widget.coin.id, interval));
                            return Future.value(1);
                          },
                          actions: intervals
                              .map(
                                (e) => ToolBarAction(
                                  width: 40,
                                  onPressed: () {
                                    interval = e;
                                    setState(() {});
                                    context.read<CandleBloc>().add(
                                        FetchCandlesEvent(
                                            widget.coin.id, interval));
                                  },
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: interval == e
                                          ? Colors.white38
                                          : Color(0xFFF0B90A),
                                    ),
                                  ),
                                ),
                              )
                              .toList());
                    }),
                  ),
                ),
              SizedBox(height: 32.63),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
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
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  SizedBox(width: 16),
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white38,
                  ),
                  SizedBox(width: 16),
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
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => SizedBox()));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
