import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/food_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/food_card.dart';
import 'cart_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const Color primaryColor = Color(0xFFFF5A5F);
  static const Color lightCoral = Color(0xFFFFE8E8);

  String selectedCategory = 'All';
  String selectedDeliveryType = 'Standard';
  String searchText = '';

  late final TextEditingController _searchController;

  final List<String> categories = [
    'All',
    'Pizza',
    'Burger',
    'Biryani',
    'Chinese',
    'Desserts',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // SEARCH
  // ==========================================================

  void _searchFood(String value) {
    setState(() {
      searchText = value;
    });
  }

  // ==========================================================
  // CATEGORY
  // ==========================================================

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // ==========================================================
  // DELIVERY TYPE
  // ==========================================================

  void _selectDeliveryType(String? value) {
    if (value == null) return;

    setState(() {
      selectedDeliveryType = value;
    });
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDark =
        theme.brightness == Brightness.dark;

    // ========================================================
    // RIVERPOD FOOD DATA
    // ========================================================

    final foods = ref.watch(foodProvider);

    // ========================================================
    // FILTER FOOD
    // ========================================================

    final filteredFoods = foods.where((food) {
      final categoryMatches =
          selectedCategory == 'All' ||
              food.category == selectedCategory;

      final query =
      searchText.trim().toLowerCase();

      final searchMatches =
          query.isEmpty ||
              food.name
                  .toLowerCase()
                  .contains(query) ||
              food.category
                  .toLowerCase()
                  .contains(query) ||
              food.restaurant
                  .toLowerCase()
                  .contains(query);

      return categoryMatches && searchMatches;
    }).toList();

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,

        title: const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Droply',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Food delivered with love ❤️',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),

        actions: [
          // ====================================================
          // CART
          // ====================================================

          Consumer(
            builder: (
                context,
                ref,
                child,
                ) {
              final cart =
              ref.watch(cartProvider);

              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const CartPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),

                  if (cart.isNotEmpty)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding:
                        const EdgeInsets.all(4),
                        constraints:
                        const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        decoration:
                        const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cart.length}',
                          textAlign:
                          TextAlign.center,
                          style:
                          const TextStyle(
                            color: primaryColor,
                            fontSize: 10,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: ListView(
        padding:
        const EdgeInsets.all(20),
        children: [
          // ======================================================
          // LOCATION
          // ======================================================

          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.all(9),
                decoration:
                BoxDecoration(
                  color: isDark
                      ? primaryColor
                      .withValues(alpha: 0.18)
                      : lightCoral,
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 21,
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivering to',
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.onSurface
                          .withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Anna Nagar, Chennai',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      colors.onSurface,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Icon(
                Icons.keyboard_arrow_down,
                color:
                colors.onSurface,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ======================================================
          // GREETING
          // ======================================================

          Text(
            'Hungry? 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight:
              FontWeight.bold,
              color:
              colors.onSurface,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Find your favourite food and get it delivered.',
            style: TextStyle(
              fontSize: 15,
              color: colors.onSurface
                  .withValues(alpha: 0.65),
            ),
          ),

          const SizedBox(height: 22),

          // ======================================================
          // SEARCH BAR
          // ======================================================

          Container(
            decoration:
            BoxDecoration(
              color: colors.surface,
              borderRadius:
              BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(
                    alpha:
                    isDark ? 0.25 : 0.06,
                  ),
                  blurRadius: 12,
                  offset:
                  const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller:
              _searchController,
              onChanged: _searchFood,
              style: TextStyle(
                color:
                colors.onSurface,
              ),
              decoration:
              InputDecoration(
                prefixIcon:
                const Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                hintText:
                'Search for food, restaurants...',
                hintStyle: TextStyle(
                  color: colors.onSurface
                      .withValues(
                    alpha: 0.5,
                  ),
                  fontSize: 14,
                ),
                suffixIcon:
                searchText.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    _searchController
                        .clear();

                    setState(() {
                      searchText =
                      '';
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: colors
                        .onSurface,
                  ),
                )
                    : null,
                border:
                InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(
                  vertical: 17,
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ======================================================
          // OFFER BANNER
          // ======================================================

          Container(
            height: 150,
            padding:
            const EdgeInsets.all(20),
            decoration:
            BoxDecoration(
              gradient:
              const LinearGradient(
                colors: [
                  Color(0xFFFF5A5F),
                  Color(0xFFFF8A65),
                ],
              ),
              borderRadius:
              BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      const Text(
                        'Hungry for a deal?',
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 6,
                      ),

                      const Text(
                        'Get 30% OFF on your first order',
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration:
                        BoxDecoration(
                          color:
                          Colors.white,
                          borderRadius:
                          BorderRadius
                              .circular(
                            20,
                          ),
                        ),
                        child:
                        const Text(
                          'USE: DROP30',
                          style:
                          TextStyle(
                            color:
                            primaryColor,
                            fontSize: 12,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.fastfood,
                  size: 65,
                  color:
                  Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ======================================================
          // CATEGORIES
          // ======================================================

          Text(
            'What are you craving?',
            style: TextStyle(
              fontSize: 21,
              fontWeight:
              FontWeight.bold,
              color:
              colors.onSurface,
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection:
              Axis.horizontal,
              itemCount:
              categories.length,
              separatorBuilder:
                  (context, index) =>
              const SizedBox(
                width: 10,
              ),
              itemBuilder:
                  (context, index) {
                final category =
                categories[index];

                final isSelected =
                    selectedCategory ==
                        category;

                return GestureDetector(
                  onTap: () {
                    _selectCategory(
                      category,
                    );
                  },
                  child:
                  AnimatedContainer(
                    duration:
                    const Duration(
                      milliseconds: 200,
                    ),
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 18,
                    ),
                    alignment:
                    Alignment.center,
                    decoration:
                    BoxDecoration(
                      color: isSelected
                          ? primaryColor
                          : colors.surface,
                      borderRadius:
                      BorderRadius
                          .circular(
                        25,
                      ),
                      border:
                      Border.all(
                        color: isSelected
                            ? primaryColor
                            : colors
                            .outline
                            .withValues(
                          alpha: 0.25,
                        ),
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : colors
                            .onSurface,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // ======================================================
          // POPULAR FOOD
          // ======================================================

          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
            children: [
              Text(
                'Popular near you',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight:
                  FontWeight.bold,
                  color:
                  colors.onSurface,
                ),
              ),

              TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategory =
                    'All';
                    searchText = '';
                    _searchController
                        .clear();
                  });
                },
                child:
                const Text(
                  'See all',
                  style:
                  TextStyle(
                    color:
                    primaryColor,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ======================================================
          // DYNAMIC FOOD CARDS
          // ======================================================

          if (filteredFoods.isEmpty)
            Container(
              padding:
              const EdgeInsets.all(30),
              decoration:
              BoxDecoration(
                color:
                colors.surface,
                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons
                        .restaurant_outlined,
                    size: 55,
                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.4,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    'No food available',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w600,
                      color:
                      colors.onSurface,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredFoods.map(
                  (food) {
                return Padding(
                  padding:
                  const EdgeInsets
                      .only(
                    bottom: 15,
                  ),
                  child: FoodCard(
                    food: food,

                    // ==================================================
                    // ADD TO CART
                    // ==================================================

                    onAdd: () {
                      ref
                          .read(
                        cartProvider
                            .notifier,
                      )
                          .addToCart(food);

                      ScaffoldMessenger
                          .of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${food.name} added to cart',
                          ),
                          backgroundColor:
                          primaryColor,
                          duration:
                          const Duration(
                            seconds: 2,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

          const SizedBox(height: 15),

          // ======================================================
          // DELIVERY SPEED
          // ======================================================

          Text(
            'Choose delivery speed',
            style: TextStyle(
              fontSize: 21,
              fontWeight:
              FontWeight.bold,
              color:
              colors.onSurface,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            decoration:
            BoxDecoration(
              color:
              colors.surface,
              borderRadius:
              BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(
                    alpha:
                    isDark ? 0.25 : 0.04,
                  ),
                  blurRadius: 8,
                  offset:
                  const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'Standard',
                  groupValue:
                  selectedDeliveryType,
                  activeColor:
                  primaryColor,
                  title: Text(
                    'Standard Delivery',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.w600,
                      color:
                      colors.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    '30 - 45 minutes',
                    style: TextStyle(
                      color: colors
                          .onSurface
                          .withValues(
                        alpha: 0.65,
                      ),
                    ),
                  ),
                  onChanged:
                  _selectDeliveryType,
                ),

                RadioListTile<String>(
                  value: 'Express',
                  groupValue:
                  selectedDeliveryType,
                  activeColor:
                  primaryColor,
                  title: Text(
                    'Express Delivery',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.w600,
                      color:
                      colors.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    '15 - 25 minutes',
                    style: TextStyle(
                      color: colors
                          .onSurface
                          .withValues(
                        alpha: 0.65,
                      ),
                    ),
                  ),
                  onChanged:
                  _selectDeliveryType,
                ),

                RadioListTile<String>(
                  value: 'Priority',
                  groupValue:
                  selectedDeliveryType,
                  activeColor:
                  primaryColor,
                  title: Text(
                    'Priority Delivery',
                    style: TextStyle(
                      fontWeight:
                      FontWeight.w600,
                      color:
                      colors.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    '10 - 15 minutes',
                    style: TextStyle(
                      color: colors
                          .onSurface
                          .withValues(
                        alpha: 0.65,
                      ),
                    ),
                  ),
                  onChanged:
                  _selectDeliveryType,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ======================================================
          // SELECTED DELIVERY
          // ======================================================

          Container(
            padding:
            const EdgeInsets.all(18),
            decoration:
            BoxDecoration(
              color: isDark
                  ? primaryColor
                  .withValues(
                alpha: 0.16,
              )
                  : lightCoral,
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delivery_dining,
                  color:
                  primaryColor,
                  size: 30,
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Text(
                    '$selectedDeliveryType delivery selected',
                    style: TextStyle(
                      color:
                      colors.onSurface,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ======================================================
          // ORDER NOW
          // ======================================================

          SizedBox(
            width:
            double.infinity,
            child:
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      '$selectedDeliveryType delivery selected',
                    ),
                    backgroundColor:
                    primaryColor,
                  ),
                );
              },
              icon:
              const Icon(
                Icons
                    .shopping_bag_outlined,
              ),
              label:
              const Text(
                'Order Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                primaryColor,
                foregroundColor:
                Colors.white,
                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 16,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    16,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}