import 'package:flutter/material.dart';

import '../models/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback? onAdd;

  const FoodCard({
    super.key,
    required this.food,
    this.onAdd,
  });

  static const Color primaryColor =
  Color(0xFFFF5A5F);

  static const Color lightCoral =
  Color(0xFFFFE8E8);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final isDark =
        theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: colors.surface,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.25 : 0.05,
            ),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ====================================================
          // FOOD IMAGE / EMOJI
          // ====================================================

          Container(
            width: 75,
            height: 75,

            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: isDark
                  ? primaryColor.withValues(
                alpha: 0.18,
              )
                  : lightCoral,

              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Text(
              food.image,

              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ),

          const SizedBox(width: 15),

          // ====================================================
          // FOOD INFORMATION
          // ====================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  food.name,

                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight:
                    FontWeight.bold,

                    color:
                    colors.onSurface,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  food.restaurant,

                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 13,

                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.65,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${food.category} • ${food.deliveryTime} min',

                  style: TextStyle(
                    fontSize: 12,

                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.55,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Color(
                        0xFFFFB300,
                      ),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      food.rating
                          .toString(),

                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w600,

                        color:
                        colors.onSurface,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      '₹${food.price.toStringAsFixed(0)}',

                      style:
                      const TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.bold,

                        color:
                        primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ====================================================
          // ADD BUTTON
          // ====================================================

          Container(
            decoration: BoxDecoration(
              color: primaryColor,

              borderRadius:
              BorderRadius.circular(12),
            ),

            child: IconButton(
              onPressed: onAdd,

              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}