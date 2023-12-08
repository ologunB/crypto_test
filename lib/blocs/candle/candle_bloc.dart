import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:crypto_test/repos/repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/candle_model.dart';

part 'candle_event.dart';
part 'candle_state.dart';

class CandleBloc extends Bloc<CandleEvent, CandleState> {
  final Repo _candleRepo;
  WebSocketChannel? _channel;

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }

  CandleBloc(this._candleRepo) : super(CandleLoadingState()) {
    on<FetchCandlesEvent>(_onFetchCandles);
    on<LoadMoreCandlesEvent>(_onLoadMore);
    on<UpdateCandlesEvent>(_updateCandlesFromSnapshot);
  }

  Future<void> _onFetchCandles(event, emit) async {
    _channel?.sink.close();

    // Establish a new WebSocket connection
    _channel = _candleRepo.establishConnection(
        event.symbol.toLowerCase(), event.interval);

    // Listen to the channel and handle incoming data
    _channel?.stream.listen((data) {
      add(UpdateCandlesEvent(data));
    });

    emit(CandleLoadingState());

    try {
      final data = await _candleRepo.fetchCandles(
          symbol: event.symbol, interval: event.interval);
      emit(CandleLoadedState(candles: data));
    } catch (e) {
      emit(CandleErrorState(error: e.toString()));
    }
  }

  Future<void> _onLoadMore(event, emit) async {
    try {
      final data = await _candleRepo.fetchCandles(
          symbol: event.symbol, interval: event.interval);

      emit(CandleLoadedState(candles: data));
    } catch (e) {
      emit(CandleErrorState(error: e.toString()));
    }
  }

  void _updateCandlesFromSnapshot(event, emit) {
    dynamic snapshot = event.snapshot;
    if (state is! CandleLoadedState) return;
    List<Candle> candles = List.from((state as CandleLoadedState).candles);

    if (candles.isEmpty) return;
    if (snapshot != null) {
      final map = jsonDecode(snapshot as String) as Map<String, dynamic>;
      if (map.containsKey("k") == true) {
        final candleTicker = CandleTickerModel.fromJson(map);

        Candle first = candles[0];
        if (first.date == candleTicker.candle.date &&
            first.open == candleTicker.candle.open) {
          // update last candle
          first = candleTicker.candle;
        } else if (candleTicker.candle.date.difference(first.date) ==
            first.date.difference(candles[1].date)) {
          // add new candle to list
          candles.insert(0, candleTicker.candle);
        }
      }
      emit(CandleLoadedState(candles: candles));
    }
  }
}
