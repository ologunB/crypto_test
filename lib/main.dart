import 'package:crypto_test/blocs/candle/candle_bloc.dart';
import 'package:crypto_test/repos/repo.dart';
import 'package:crypto_test/views/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/coin/coin_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CoinBloc(RepositoryProvider.of<Repo>(context)),
          ),
          BlocProvider(
            create: (context) =>
                CandleBloc(RepositoryProvider.of<Repo>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Crypto Test',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainLayout(),
        ),
      ),
    );
  }
}
