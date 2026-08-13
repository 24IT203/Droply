import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'pages/home_page.dart';
import 'pages/orders_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const DroplyApp());
}

// ============================================================
// DROPly APP
// ============================================================

class DroplyApp extends StatefulWidget {
  const DroplyApp({super.key});

  @override
  State<DroplyApp> createState() => _DroplyAppState();
}

class _DroplyAppState extends State<DroplyApp> {

  // ==========================================================
  // DAY 4 - DARK MODE STATE
  // ==========================================================

  bool _isDarkMode = false;

  // ==========================================================
  // CHANGE DARK MODE
  // ==========================================================

  void _changeDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droply',

      debugShowCheckedModeBanner: false,

      // ======================================================
      // LIGHT THEME
      // ======================================================

      theme: ThemeData(
        brightness: Brightness.light,

        scaffoldBackgroundColor:
        const Color(0xFFFFF8F3),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A5F),
          brightness: Brightness.light,
        ),

        useMaterial3: true,
      ),

      // ======================================================
      // DARK THEME
      // ======================================================

      darkTheme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor:
        const Color(0xFF121212),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5A5F),
          brightness: Brightness.dark,
        ),

        useMaterial3: true,
      ),

      // ======================================================
      // SELECT THEME
      // ======================================================

      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      // ======================================================
      // NAVIGATION
      // ======================================================

      home: DroplyNavigation(
        isDarkMode: _isDarkMode,
        onDarkModeChanged: _changeDarkMode,
      ),
    );
  }
}

// ============================================================
// MAIN NAVIGATION
// ============================================================

class DroplyNavigation extends StatefulWidget {

  final bool isDarkMode;

  final ValueChanged<bool> onDarkModeChanged;

  const DroplyNavigation({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<DroplyNavigation> createState() =>
      _DroplyNavigationState();
}

class _DroplyNavigationState
    extends State<DroplyNavigation> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    // ========================================================
    // ALL PAGES
    // ========================================================

    final List<Widget> pages = [
      const HomePage(),

      const OrdersPage(),

      ProfilePage(
        isDarkMode: widget.isDarkMode,
        onDarkModeChanged:
        widget.onDarkModeChanged,
      ),
    ];

    return Scaffold(

      // ======================================================
      // PAGE CONTENT
      // ======================================================

      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      // ======================================================
      // STYLISH BOTTOM NAVIGATION BAR
      // ======================================================

      bottomNavigationBar: StylishBottomBar(

        option: AnimatedBarOptions(
          iconSize: 28,

          barAnimation: BarAnimation.fade,

          iconStyle: IconStyle.Default,

          opacity: 0.3,
        ),

        currentIndex: selectedIndex,

        // Changes automatically with dark mode
        backgroundColor:
        Theme.of(context).scaffoldBackgroundColor,

        elevation: 8,

        items: [

          // ==================================================
          // HOME
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),

            selectedIcon: const Icon(
              Icons.home,
            ),

            title: const Text(
              'Home',
            ),

            backgroundColor:
            const Color(0xFFFF5A5F),
          ),

          // ==================================================
          // ORDERS
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons.inventory_2_outlined,
            ),

            selectedIcon: const Icon(
              Icons.inventory_2,
            ),

            title: const Text(
              'Orders',
            ),

            backgroundColor:
            const Color(0xFFFF5A5F),
          ),

          // ==================================================
          // PROFILE
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons.person_outline,
            ),

            selectedIcon: const Icon(
              Icons.person,
            ),

            title: const Text(
              'Profile',
            ),

            backgroundColor:
            const Color(0xFFFF5A5F),
          ),
        ],

        // ======================================================
        // TAB SELECTION
        // ======================================================

        onTap: (index) {

          setState(() {
            selectedIndex = index;
          });

        },
      ),
    );
  }
}