part of 'coin_bloc.dart';

abstract class CoinState extends Equatable {
  const CoinState();
  @override
  List<Object> get props => [];
}

class CoinLoadingState extends CoinState {}

class CoinLoadedState extends CoinState {
  final List<Coin> coins;
  const CoinLoadedState({required this.coins});
  @override
  List<Object> get props => [coins];
}

class CoinErrorState extends CoinState {
  final String error;
  const CoinErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
