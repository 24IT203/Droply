import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';
import 'pages/orders_page.dart';
import 'pages/profile_page.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DroplyApp(),
    ),
  );
}

// ============================================================
// DROPly APP
// ============================================================

class DroplyApp extends ConsumerWidget {
  const DroplyApp({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    // ========================================================
    // RIVERPOD THEME
    // ========================================================

    final themeMode =
    ref.watch(themeProvider);

    return MaterialApp(
      title: 'Droply',

      debugShowCheckedModeBanner: false,

      // ======================================================
      // LIGHT THEME
      // ======================================================

      theme: ThemeData(
        brightness:
        Brightness.light,

        scaffoldBackgroundColor:
        const Color(0xFFFFF8F3),

        colorScheme:
        ColorScheme.fromSeed(
          seedColor:
          const Color(0xFFFF5A5F),

          brightness:
          Brightness.light,
        ),

        // ====================================================
        // GOOGLE FONT
        // ====================================================

        textTheme:
        GoogleFonts.poppinsTextTheme(),

        appBarTheme:
        const AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),

        useMaterial3: true,
      ),

      // ======================================================
      // DARK THEME
      // ======================================================

      darkTheme: ThemeData(
        brightness:
        Brightness.dark,

        scaffoldBackgroundColor:
        const Color(0xFF121212),

        colorScheme:
        ColorScheme.fromSeed(
          seedColor:
          const Color(0xFFFF5A5F),

          brightness:
          Brightness.dark,
        ),

        // ====================================================
        // GOOGLE FONT
        // ====================================================

        textTheme:
        GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),

        appBarTheme:
        const AppBarTheme(
          elevation: 0,
          centerTitle: false,
        ),

        useMaterial3: true,
      ),

      // ======================================================
      // RIVERPOD CONTROLS THEME
      // ======================================================

      themeMode:
      themeMode,

      // ======================================================
      // MAIN NAVIGATION
      // ======================================================

      home:
      const DroplyNavigation(),
    );
  }
}

// ============================================================
// MAIN NAVIGATION
// ============================================================

class DroplyNavigation
    extends StatefulWidget {
  const DroplyNavigation({
    super.key,
  });

  @override
  State<DroplyNavigation>
  createState() =>
      _DroplyNavigationState();
}

class _DroplyNavigationState
    extends State<DroplyNavigation> {
  int selectedIndex = 0;

  // ==========================================================
  // ALL PAGES
  // ==========================================================

  final List<Widget> pages = const [
    HomePage(),
    OrdersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(
      BuildContext context,
      ) {
    final theme =
    Theme.of(context);

    // ========================================================
    // MAIN SCAFFOLD
    // ========================================================

    return Scaffold(
      // ======================================================
      // PAGE CONTENT
      // ======================================================

      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      // ======================================================
      // BOTTOM NAVIGATION
      // ======================================================

      bottomNavigationBar:
      StylishBottomBar(
        option:
        AnimatedBarOptions(
          iconSize: 28,

          barAnimation:
          BarAnimation.fade,

          iconStyle:
          IconStyle.Default,

          opacity: 0.3,
        ),

        currentIndex:
        selectedIndex,

        // Automatically changes
        // according to dark/light mode
        backgroundColor:
        theme.colorScheme.surface,

        elevation: 8,

        items: [
          // ==================================================
          // HOME
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),

            selectedIcon:
            const Icon(
              Icons.home,
            ),

            title: const Text(
              'Home',
            ),

            backgroundColor:
            const Color(
              0xFFFF5A5F,
            ),
          ),

          // ==================================================
          // ORDERS
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons
                  .inventory_2_outlined,
            ),

            selectedIcon:
            const Icon(
              Icons.inventory_2,
            ),

            title: const Text(
              'Orders',
            ),

            backgroundColor:
            const Color(
              0xFFFF5A5F,
            ),
          ),

          // ==================================================
          // PROFILE
          // ==================================================

          BottomBarItem(
            icon: const Icon(
              Icons.person_outline,
            ),

            selectedIcon:
            const Icon(
              Icons.person,
            ),

            title: const Text(
              'Profile',
            ),

            backgroundColor:
            const Color(
              0xFFFF5A5F,
            ),
          ),
        ],

        // ======================================================
        // TAB SELECTION
        // ======================================================

        onTap: (index) {
          setState(() {
            selectedIndex =
                index;
          });
        },
      ),
    );
  }
}