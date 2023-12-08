import 'package:crypto_test/views/home/page.dart';
import 'package:crypto_test/views/markets/page.dart';
import 'package:crypto_test/views/widgets/colors.dart';
import 'package:crypto_test/views/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: const [HomeScreen(), MarketsScreen()],
        index: currentIndex,
      ),
      backgroundColor: AppColors.primary,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black.withOpacity(.2),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.white,
        iconSize: 20,
        selectedLabelStyle: GoogleFonts.actor(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        unselectedLabelStyle: GoogleFonts.actor(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: const Color(0xff363636),
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (i) {
          currentIndex = i;
          setState(() {});
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [0, 1]
            .map(
              (a) => BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Image.asset(
                    'h0${a}'.png,
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Image.asset(
                    'h1${a}'.png,
                    height: 24,
                    width: 24,
                    color: Colors.white,
                  ),
                ),
                label: ['1', '2'][a],
              ),
            )
            .toList(),
      ),
    );
  }
}
