import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinRepo {
  Future<Map<String, String>> fetchIcons() async {
    try {
      final uri = Uri.parse("https://rest.coinapi.io/v1/assets/icons/33");
      final res = await http.get(uri, headers: {
        'Accept': 'text/plain',
        'X-CoinAPI-Key': '57B3048E-B79A-4DD3-A4A3-A8202691CF60',
      });
      Map<String, String> all = {};
      jsonDecode(res.body).forEach((e) {
        all.putIfAbsent(e['asset_id'], () => e['url']);
      });
      return all;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchPrices() async {
    try {
      final uri = Uri.parse(
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest");
      final res = await http.get(uri, headers: {
        'X-CMC_PRO_API_KEY': '73d9f6ab-0766-4f42-ba93-4ceccc183522',
      });
      Map<String, dynamic> all = {};
      jsonDecode(res.body)['data'].forEach((e) {
        all.putIfAbsent(e['symbol'], () => e);
      });
      return all;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Candle>> fetchCandles(
      {required String symbol, required String interval, int? endTime}) async {
    try {
      final uri = Uri.parse(
          "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval" +
              (endTime != null ? "&endTime=$endTime" : ""));
      final res = await http.get(uri);
      return (jsonDecode(res.body) as List<dynamic>)
          .map((e) => Candle.fromJson(e))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> fetchPairs() async {
    final uri = Uri.parse("https://api.binance.com/api/v3/ticker/price");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => e["symbol"] as String)
        .toList();
  }

  WebSocketChannel establishConnection(String symbol, String interval) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );
    channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": [symbol + "@kline_" + interval],
          "id": 1
        },
      ),
    );
    return channel;
  }
}
