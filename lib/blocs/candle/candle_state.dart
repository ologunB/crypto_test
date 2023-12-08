part of 'candle_bloc.dart';

abstract class CandleState extends Equatable {
  const CandleState();
  @override
  List<Object> get props => [];
}

class CandleLoadingState extends CandleState {}

class CandleErrorState extends CandleState {
  final String error;
  const CandleErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class CandleLoadedState extends CandleState {
  final List<Candle> candles;

  CandleLoadedState({required this.candles});
  @override
  List<Object> get props => [candles];
}
