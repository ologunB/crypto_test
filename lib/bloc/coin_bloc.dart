import 'package:crypto_test/models/coin_model.dart';
import 'package:crypto_test/repos/coin_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_event.dart';
part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepo _coinRepo;

  CoinBloc(this._coinRepo) : super(CoinLoadingState()) {
    on<LoadCoinsEvent>((event, emit) async {
      emit(CoinLoadingState());
      try {
        List<Coin> coins = [];
        final icons = await _coinRepo.fetchIcons();
        print(icons);
        final prices = await _coinRepo.fetchPrices();
        print(prices);
        final pairs = await _coinRepo.fetchPairs();
        print(pairs);

        for (String pair in pairs) {
          if (!pair.contains('USDT')) continue;
          String a = pair.replaceAll('USDT', '');
          if (!prices.containsKey(a)) continue;
          if (!icons.containsKey(a)) continue;
          coins.add(
            Coin(
              id: pair,
              name: prices[a]!['name'],
              symbol: a,
              image: icons[a]!,
              price: prices[a]!['quote']['USD']['price'],
              change24h: prices[a]!['quote']['USD']['percent_change_24h'],
            ),
          );
        }

        emit(CoinLoadedState(coins: coins));
      } catch (e) {
        emit(CoinErrorState(error: e.toString()));
      }
    });
  }
}
