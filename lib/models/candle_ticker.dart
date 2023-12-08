import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_test/repos/coin_repo.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CandleTickerModel {
  final int eventTime;
  final String symbol;
  final Candle candle;

  const CandleTickerModel(
      {required this.eventTime, required this.symbol, required this.candle});

  factory CandleTickerModel.fromJson(Map<String, dynamic> json) {
    return CandleTickerModel(
        eventTime: json['E'] as int,
        symbol: json['s'] as String,
        candle: Candle(
            date: DateTime.fromMillisecondsSinceEpoch(json["k"]["t"]),
            high: double.parse(json["k"]["h"]),
            low: double.parse(json["k"]["l"]),
            open: double.parse(json["k"]["o"]),
            close: double.parse(json["k"]["c"]),
            volume: double.parse(json["k"]["v"])));
  }
}

class TestCandle extends StatefulWidget {
  const TestCandle({Key? key}) : super(key: key);

  @override
  _TestCandleState createState() => _TestCandleState();
}

class _TestCandleState extends State<TestCandle> {
  CoinRepo repository = CoinRepo();

  List<Candle> candles = [];
  WebSocketChannel? _channel;
  bool themeIsDark = false;
  String currentInterval = "1m";
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
  List<String> symbols = [];
  String currentSymbol = "";

  @override
  void initState() {
    fetchSymbols().then((value) {
      symbols = value;
      if (symbols.isNotEmpty) fetchCandles(symbols[0], currentInterval);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_channel != null) _channel!.sink.close();
    super.dispose();
  }

  Future<List<String>> fetchSymbols() async {
    try {
      final data = await repository.fetchPairs();
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> fetchCandles(String symbol, String interval) async {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
    setState(() {
      currentInterval = interval;
    });

    try {
      final data =
          await repository.fetchCandles(symbol: symbol, interval: interval);
      _channel =
          repository.establishConnection(symbol.toLowerCase(), currentInterval);
      if (data.isNotEmpty) {
        setState(() {
          candles = data;
          currentInterval = interval;
          currentSymbol = symbol;
        });
      }
    } catch (e) {
      return;
    }
  }

  void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    if (candles.isEmpty) return;
    if (snapshot.data != null) {
      final map = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
      if (map.containsKey("k") == true) {
        final candleTicker = CandleTickerModel.fromJson(map);

        if (candles[0].date == candleTicker.candle.date &&
            candles[0].open == candleTicker.candle.open) {
          // update last candle
          candles[0] = candleTicker.candle;
        } else if (candleTicker.candle.date.difference(candles[0].date) ==
            candles[0].date.difference(candles[1].date)) {
          // add new candle to list
          candles.insert(0, candleTicker.candle);
        }
      }
    }
  }

  Future<void> loadMoreCandles() async {
    try {
      final data = await repository.fetchCandles(
          symbol: currentSymbol,
          interval: currentInterval,
          endTime: candles.last.date.millisecondsSinceEpoch);
      candles.removeLast();
      setState(() {
        candles.addAll(data);
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Binance Candles"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeIsDark = !themeIsDark;
                });
              },
              icon: Icon(
                themeIsDark
                    ? Icons.wb_sunny_sharp
                    : Icons.nightlight_round_outlined,
              ),
            )
          ],
        ),
        body: Center(
          child: StreamBuilder(
            stream: _channel == null ? null : _channel!.stream,
            builder: (context, snapshot) {
              updateCandlesFromSnapshot(snapshot);
              return Candlesticks(
                key: Key(currentSymbol + currentInterval),
                candles: candles,
                onLoadMoreCandles: loadMoreCandles,
                actions: [
                  ...intervals.map(
                    (e) => ToolBarAction(
                      width: 40,
                      onPressed: () {
                        currentSymbol = e;
                        setState(() {});
                        fetchCandles(currentSymbol, e);
                      },
                      child: Text(
                        e,
                        style: TextStyle(
                          color: currentSymbol == e
                              ? Colors.white38
                              : Color(0xFFF0B90A),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
