import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const Color primaryColor =
  Color(0xFFFF5A5F);

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final cart =
    ref.watch(cartProvider);

    final cartNotifier =
    ref.read(cartProvider.notifier);

    final theme =
    Theme.of(context);

    final colors =
        theme.colorScheme;

    // ==========================================================
    // EMPTY CART
    // ==========================================================

    if (cart.isEmpty) {
      return Scaffold(
        backgroundColor:
        theme.scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor:
          primaryColor,

          foregroundColor:
          Colors.white,

          elevation: 0,

          title: const Text(
            'My Cart',

            style: TextStyle(
              fontSize: 23,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        body: Center(
          child: Padding(
            padding:
            const EdgeInsets.all(30),

            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [
                Container(
                  padding:
                  const EdgeInsets.all(
                    25,
                  ),

                  decoration:
                  BoxDecoration(
                    color: primaryColor
                        .withValues(
                      alpha: 0.12,
                    ),

                    shape:
                    BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons
                        .shopping_cart_outlined,

                    size: 70,

                    color:
                    primaryColor,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                Text(
                  'Your cart is empty',

                  style: TextStyle(
                    fontSize: 23,

                    fontWeight:
                    FontWeight.bold,

                    color:
                    colors.onSurface,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  'Add some delicious food to your cart and order now!',

                  textAlign:
                  TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,

                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.6,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },

                  style:
                  ElevatedButton
                      .styleFrom(
                    backgroundColor:
                    primaryColor,

                    foregroundColor:
                    Colors.white,

                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 25,
                      vertical: 14,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        14,
                      ),
                    ),
                  ),

                  child:
                  const Text(
                    'Browse Food',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ==========================================================
    // CART WITH ITEMS
    // ==========================================================

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
        primaryColor,

        foregroundColor:
        Colors.white,

        elevation: 0,

        title: Text(
          'My Cart (${cart.length})',

          style: const TextStyle(
            fontSize: 23,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              _showClearCartDialog(
                context,
                cartNotifier,
              );
            },

            icon: const Icon(
              Icons.delete_outline,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // ====================================================
          // CART ITEMS
          // ====================================================

          Expanded(
            child: ListView.separated(
              padding:
              const EdgeInsets.all(
                20,
              ),

              itemCount:
              cart.length,

              separatorBuilder:
                  (context, index) {
                return const SizedBox(
                  height: 14,
                );
              },

              itemBuilder:
                  (context, index) {
                final food =
                cart[index];

                return Container(
                  padding:
                  const EdgeInsets.all(
                    15,
                  ),

                  decoration:
                  BoxDecoration(
                    color:
                    colors.surface,

                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .black
                            .withValues(
                          alpha: theme
                              .brightness ==
                              Brightness
                                  .dark
                              ? 0.25
                              : 0.05,
                        ),

                        blurRadius: 8,

                        offset:
                        const Offset(
                          0,
                          3,
                        ),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      // ========================================
                      // FOOD IMAGE
                      // ========================================

                      Container(
                        width: 65,
                        height: 65,

                        alignment:
                        Alignment.center,

                        decoration:
                        BoxDecoration(
                          color:
                          primaryColor
                              .withValues(
                            alpha: 0.12,
                          ),

                          borderRadius:
                          BorderRadius
                              .circular(
                            14,
                          ),
                        ),

                        child: Text(
                          food.image,

                          style:
                          const TextStyle(
                            fontSize: 34,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 14,
                      ),

                      // ========================================
                      // FOOD DETAILS
                      // ========================================

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                          children: [
                            Text(
                              food.name,

                              maxLines: 1,

                              overflow:
                              TextOverflow
                                  .ellipsis,

                              style:
                              TextStyle(
                                fontSize:
                                16,

                                fontWeight:
                                FontWeight
                                    .bold,

                                color: colors
                                    .onSurface,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              food.restaurant,

                              style:
                              TextStyle(
                                fontSize:
                                13,

                                color: colors
                                    .onSurface
                                    .withValues(
                                  alpha: 0.6,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 7,
                            ),

                            Text(
                              '₹${food.price.toStringAsFixed(0)}',

                              style:
                              const TextStyle(
                                fontSize:
                                16,

                                fontWeight:
                                FontWeight
                                    .bold,

                                color:
                                primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ========================================
                      // REMOVE BUTTON
                      // ========================================

                      IconButton(
                        onPressed: () {
                          cartNotifier
                              .removeFromCart(
                            food.id,
                          );

                          ScaffoldMessenger
                              .of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${food.name} removed from cart',
                              ),

                              duration:
                              const Duration(
                                seconds: 2,
                              ),

                              backgroundColor:
                              primaryColor,
                            ),
                          );
                        },

                        icon:
                        const Icon(
                          Icons
                              .remove_circle_outline,

                          color:
                          primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ====================================================
          // CHECKOUT SECTION
          // ====================================================

          Container(
            padding:
            const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              25,
            ),

            decoration:
            BoxDecoration(
              color:
              colors.surface,

              borderRadius:
              const BorderRadius
                  .vertical(
                top:
                Radius.circular(
                  25,
                ),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(
                    alpha: 0.08,
                  ),

                  blurRadius: 12,

                  offset:
                  const Offset(
                    0,
                    -4,
                  ),
                ),
              ],
            ),

            child: Column(
              children: [
                // ==============================================
                // ITEM COUNT
                // ==============================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

                  children: [
                    Text(
                      'Items',

                      style: TextStyle(
                        color: colors
                            .onSurface
                            .withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),

                    Text(
                      '${cart.length}',

                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,

                        color:
                        colors.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // ==============================================
                // DELIVERY FEE
                // ==============================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

                  children: [
                    Text(
                      'Delivery Fee',

                      style: TextStyle(
                        color: colors
                            .onSurface
                            .withValues(
                          alpha: 0.65,
                        ),
                      ),
                    ),

                    const Text(
                      '₹40',

                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,

                        color:
                        primaryColor,
                      ),
                    ),
                  ],
                ),

                const Padding(
                  padding:
                  EdgeInsets.symmetric(
                    vertical: 12,
                  ),

                  child: Divider(),
                ),

                // ==============================================
                // TOTAL
                // ==============================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

                  children: [
                    Text(
                      'Total',

                      style: TextStyle(
                        fontSize: 19,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        colors.onSurface,
                      ),
                    ),

                    Text(
                      '₹${(cartNotifier.totalPrice + 40).toStringAsFixed(0)}',

                      style:
                      const TextStyle(
                        fontSize: 21,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        primaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 18,
                ),

                // ==============================================
                // PLACE ORDER
                // ==============================================

                SizedBox(
                  width:
                  double.infinity,

                  child:
                  ElevatedButton.icon(
                    onPressed: () {
                      _placeOrder(
                        context,
                        cartNotifier,
                      );
                    },

                    icon:
                    const Icon(
                      Icons
                          .shopping_bag_outlined,
                    ),

                    label:
                    const Text(
                      'Place Order',

                      style:
                      TextStyle(
                        fontSize: 16,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton
                        .styleFrom(
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
                        BorderRadius
                            .circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CLEAR CART DIALOG
  // ==========================================================

  void _showClearCartDialog(
      BuildContext context,
      dynamic cartNotifier,
      ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title:
          const Text(
            'Clear Cart?',
          ),

          content:
          const Text(
            'Are you sure you want to remove all items from your cart?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child:
              const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                cartNotifier.clearCart();

                Navigator.pop(
                  context,
                );

                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Cart cleared',
                    ),

                    backgroundColor:
                    primaryColor,
                  ),
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                primaryColor,

                foregroundColor:
                Colors.white,
              ),

              child:
              const Text(
                'Clear',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // PLACE ORDER
  // ==========================================================

  void _placeOrder(
      BuildContext context,
      dynamic cartNotifier,
      ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons
                .check_circle_outline,

            color:
            primaryColor,

            size: 55,
          ),

          title:
          const Text(
            'Order Placed!',
          ),

          content:
          const Text(
            'Your delicious food is on its way. You can track your order from the Orders section.',
            textAlign:
            TextAlign.center,
          ),

          actions: [
            SizedBox(
              width:
              double.infinity,

              child:
              ElevatedButton(
                onPressed: () {
                  cartNotifier
                      .clearCart();

                  Navigator.pop(
                    context,
                  );
                },

                style: ElevatedButton
                    .styleFrom(
                  backgroundColor:
                  primaryColor,

                  foregroundColor:
                  Colors.white,
                ),

                child:
                const Text(
                  'Done',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}