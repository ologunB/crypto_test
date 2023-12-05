import 'package:crypto_test/views/widgets/colors.dart';
import 'package:flutter/material.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
    );
  }
}
