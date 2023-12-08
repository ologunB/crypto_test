import 'package:crypto_test/repos/coin_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/candle_ticker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        child: const TestCandle(),
        create: (context) => CoinRepo(),
      ),
    );
  }
}
