part of 'candle_bloc.dart';

abstract class CandleEvent extends Equatable {
  const CandleEvent();
  @override
  List<Object> get props => [];
}

class FetchCandlesEvent extends CandleEvent {
  final String symbol;
  final String interval;

  FetchCandlesEvent(this.symbol, this.interval);
}

class UpdateCandlesEvent extends CandleEvent {
  final dynamic snapshot;

  UpdateCandlesEvent(this.snapshot);
}

class LoadMoreCandlesEvent extends CandleEvent {
  final String symbol;
  final String interval;

  LoadMoreCandlesEvent(this.symbol, this.interval);
}
