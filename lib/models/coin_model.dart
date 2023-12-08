import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String name;
  final String image;
  final String symbol;
  final double price;
  final double change24h;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.price,
    required this.change24h,
  });

  @override
  List<Object?> get props => [id, name, image, symbol];
  // get from db
  static List<Coin> coins = [];
}
