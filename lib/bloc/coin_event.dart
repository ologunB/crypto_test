part of 'coin_bloc.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();
  @override
  List<Object> get props => [];
}

class LoadCoinsEvent extends CoinEvent {}

class AddCoin extends CoinEvent {
  final Coin coin;
  const AddCoin(this.coin);
  @override
  List<Object> get props => [coin];
}

class RemoveCoin extends CoinEvent {
  final Coin coin;
  const RemoveCoin(this.coin);
  @override
  List<Object> get props => [coin];
}
