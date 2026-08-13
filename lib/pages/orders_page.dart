import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // ==========================================================
  // DROPly BRAND COLORS
  // ==========================================================

  static const Color primaryColor = Color(0xFFFF5A5F);
  static const Color lightCoral = Color(0xFFFFE8E8);

  // ==========================================================
  // STATE
  // ==========================================================

  bool isOrderCancelled = false;

  int selectedRating = 0;

  // ==========================================================
  // CANCEL ORDER
  // ==========================================================

  void _cancelOrder() {
    setState(() {
      isOrderCancelled = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Order cancelled successfully',
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  // ==========================================================
  // RATING
  // ==========================================================

  void _selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      // ========================================================
      // THEME-AWARE BACKGROUND
      // ========================================================

      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: primaryColor,

        elevation: 0,

        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.receipt_long_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // ========================================================
      // ORDERS
      // ========================================================

      body: ListView(
        physics: const ClampingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        children: [
          // ======================================================
          // ACTIVE ORDER
          // ======================================================

          Text(
            'Active Order',

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 15),

          // ======================================================
          // ACTIVE ORDER CARD
          // ======================================================

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              // THEME-AWARE CARD
              color: colors.surface,

              borderRadius:
              BorderRadius.circular(22),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha:
                    theme.brightness ==
                        Brightness.dark
                        ? 0.25
                        : 0.06,
                  ),

                  blurRadius: 12,

                  offset:
                  const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                // ==================================================
                // RESTAURANT
                // ==================================================

                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,

                      decoration: BoxDecoration(
                        color: theme.brightness ==
                            Brightness.dark
                            ? primaryColor.withValues(
                          alpha: 0.18,
                        )
                            : lightCoral,

                        borderRadius:
                        BorderRadius.circular(16),
                      ),

                      child: const Icon(
                        Icons.restaurant,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Food Express',

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,

                              color:
                              colors.onSurface,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Order #DP10245',

                            style: TextStyle(
                              fontSize: 13,

                              color: colors
                                  .onSurface
                                  .withValues(
                                alpha: 0.65,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: theme.brightness ==
                            Brightness.dark
                            ? primaryColor.withValues(
                          alpha: 0.18,
                        )
                            : lightCoral,

                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Text(
                        isOrderCancelled
                            ? 'Cancelled'
                            : 'Preparing',

                        style: TextStyle(
                          color: isOrderCancelled
                              ? colors.onSurface
                              .withValues(
                            alpha: 0.55,
                          )
                              : primaryColor,

                          fontWeight:
                          FontWeight.bold,

                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ==================================================
                // FOOD ITEMS
                // ==================================================

                foodItem(
                  'Chicken Biryani',
                  '1 × ₹249',
                ),

                const SizedBox(height: 10),

                foodItem(
                  'Fresh Lime Soda',
                  '1 × ₹59',
                ),

                const Divider(
                  height: 30,
                ),

                // ==================================================
                // TOTAL
                // ==================================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Total Amount',

                      style: TextStyle(
                        fontSize: 15,

                        color: colors.onSurface
                            .withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),

                    const Text(
                      '₹308',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ==================================================
                // DELIVERY ADDRESS
                // ==================================================

                Container(
                  padding:
                  const EdgeInsets.all(13),

                  decoration: BoxDecoration(
                    color: theme.brightness ==
                        Brightness.dark
                        ? primaryColor.withValues(
                      alpha: 0.10,
                    )
                        : const Color(
                      0xFFFFF8F3,
                    ),

                    borderRadius:
                    BorderRadius.circular(14),
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: primaryColor,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          'Delivering to\nAnna Nagar, Chennai',

                          style: TextStyle(
                            fontSize: 14,

                            color:
                            colors.onSurface,

                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // TRACK BUTTON
                // ==================================================

                if (!isOrderCancelled)
                  SizedBox(
                    width: double.infinity,

                    child:
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Your order is being prepared 🍔',
                            ),

                            backgroundColor:
                            primaryColor,
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.delivery_dining,
                      ),

                      label: const Text(
                        'Track Order',
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
                          vertical: 15,
                        ),

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ==================================================
                // CANCEL BUTTON
                // ==================================================

                if (!isOrderCancelled)
                  TextButton(
                    onPressed:
                    _cancelOrder,

                    child: const Text(
                      'Cancel Order',

                      style: TextStyle(
                        color: Colors.red,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ======================================================
          // PREVIOUS ORDERS
          // ======================================================

          Text(
            'Previous Orders',

            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 15),

          previousOrder(
            'Cheese Burst Pizza',
            'Pizza Hut',
            '₹299',
            'Delivered',
            Icons.local_pizza,
          ),

          const SizedBox(height: 12),

          previousOrder(
            'Classic Burger',
            'Burger King',
            '₹199',
            'Delivered',
            Icons.lunch_dining,
          ),

          const SizedBox(height: 12),

          previousOrder(
            'Veg Noodles',
            'Chinese Wok',
            '₹219',
            'Delivered',
            Icons.ramen_dining,
          ),

          const SizedBox(height: 30),

          // ======================================================
          // RATE YOUR ORDER
          // ======================================================

          Text(
            'Rate your recent order',

            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding:
            const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: colors.surface,

              borderRadius:
              BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha:
                    theme.brightness ==
                        Brightness.dark
                        ? 0.25
                        : 0.04,
                  ),

                  blurRadius: 8,

                  offset:
                  const Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              children: [
                Text(
                  'How was your food?',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,

                    color:
                    colors.onSurface,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: List.generate(
                    5,
                        (index) {
                      final rating =
                          index + 1;

                      return IconButton(
                        onPressed: () {
                          _selectRating(
                            rating,
                          );
                        },

                        icon: Icon(
                          rating <=
                              selectedRating
                              ? Icons.star
                              : Icons.star_border,

                          color:
                          const Color(
                            0xFFFFB300,
                          ),

                          size: 34,
                        ),
                      );
                    },
                  ),
                ),

                if (selectedRating > 0)
                  Text(
                    '$selectedRating/5 stars selected',

                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // FOOD ITEM
  // ==========================================================

  Widget foodItem(
      String name,
      String price,
      ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: theme.brightness ==
                Brightness.dark
                ? primaryColor.withValues(
              alpha: 0.18,
            )
                : lightCoral,

            borderRadius:
            BorderRadius.circular(12),
          ),

          child: const Icon(
            Icons.fastfood_outlined,
            color: primaryColor,
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            name,

            style: TextStyle(
              fontSize: 15,
              fontWeight:
              FontWeight.w600,

              color:
              colors.onSurface,
            ),
          ),
        ),

        Text(
          price,

          style: TextStyle(
            fontSize: 14,

            color: colors.onSurface
                .withValues(
              alpha: 0.65,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PREVIOUS ORDER CARD
  // ==========================================================

  Widget previousOrder(
      String foodName,
      String restaurant,
      String price,
      String status,
      IconData icon,
      ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding:
      const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: colors.surface,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha:
              theme.brightness ==
                  Brightness.dark
                  ? 0.25
                  : 0.04,
            ),

            blurRadius: 8,

            offset:
            const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              color: theme.brightness ==
                  Brightness.dark
                  ? primaryColor.withValues(
                alpha: 0.18,
              )
                  : lightCoral,

              borderRadius:
              BorderRadius.circular(15),
            ),

            child: Icon(
              icon,

              color: primaryColor,

              size: 32,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  foodName,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,

                    color:
                    colors.onSurface,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  restaurant,

                  style: TextStyle(
                    fontSize: 13,

                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.65,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  '',
                ),

                Text(
                  price,

                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,

                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),

              const SizedBox(height: 5),

              Text(
                status,

                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}