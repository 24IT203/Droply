import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryColor = Color(0xFFFF5A5F);
  static const Color darkColor = Color(0xFF202124);
  static const Color creamColor = Color(0xFFFFF8F3);
  static const Color lightCoral = Color(0xFFFFE8E8);
  static const Color secondaryColor = Color(0xFFFF9F43);
  static const Color textColor = Color(0xFF555555);

  // ==========================================================
  // DAY 4 - STATE
  // ==========================================================

  String selectedCategory = 'All';

  String selectedDeliveryType = 'Standard';

  // ==========================================================
  // DAY 4 - TEXT EDITING CONTROLLER
  // ==========================================================

  late final TextEditingController _searchController;

  String searchText = '';

  // ==========================================================
  // FOOD CATEGORIES
  // ==========================================================

  final List<String> categories = [
    'All',
    'Pizza',
    'Burger',
    'Biryani',
    'Chinese',
    'Desserts',
  ];

  // ==========================================================
  // INIT STATE
  // ==========================================================

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    debugPrint('HomePage initState called');
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    _searchController.dispose();

    debugPrint('HomePage disposed');

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
  // CATEGORY SELECTION
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

    debugPrint(
      'HomePage build - category: $selectedCategory',
    );

    return Scaffold(
      backgroundColor: creamColor,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: primaryColor,

        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          IconButton(
            onPressed: () {},

            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 5),
        ],
      ),

      // ======================================================
      // HOME CONTENT
      // ======================================================

      body: ListView(
        physics: const ClampingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        children: [

          // ==================================================
          // LOCATION
          // ==================================================

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(9),

                decoration: BoxDecoration(
                  color: lightCoral,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 21,
                ),
              ),

              const SizedBox(width: 10),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Delivering to',
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    'Anna Nagar, Chennai',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkColor,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Icon(
                Icons.keyboard_arrow_down,
                color: darkColor,
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ==================================================
          // WELCOME
          // ==================================================

          const Text(
            'Hungry, Ananya? 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Find your favourite food and get it delivered.',
            style: TextStyle(
              fontSize: 15,
              color: textColor,
            ),
          ),

          const SizedBox(height: 22),

          // ==================================================
          // SEARCH BAR
          // ==================================================

          Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(18),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: TextField(
              controller: _searchController,

              onChanged: _searchFood,

              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: primaryColor,
                ),

                hintText: 'Search for food, restaurants...',

                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),

                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                  onPressed: () {
                    _searchController.clear();

                    setState(() {
                      searchText = '';
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                )
                    : null,

                border: InputBorder.none,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17,
                ),
              ),
            ),
          ),

          // ==================================================
          // SEARCH PREVIEW
          // ==================================================

          if (searchText.isNotEmpty) ...[
            const SizedBox(height: 10),

            Text(
              'Searching for "$searchText"',
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],

          const SizedBox(height: 28),

          // ==================================================
          // OFFER BANNER
          // ==================================================

          Container(
            height: 150,

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF5A5F),
                  Color(0xFFFF8A65),
                ],
              ),

              borderRadius: BorderRadius.circular(22),
            ),

            child: Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      const Text(
                        'Hungry for a deal?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Get 30% OFF on your first order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),

                        child: const Text(
                          'USE: DROP30',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.fastfood,
                  size: 65,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ==================================================
          // CATEGORIES
          // ==================================================

          const Text(
            'What are you craving?',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 48,

            child: ListView.separated(
              scrollDirection: Axis.horizontal,

              itemCount: categories.length,

              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },

              itemBuilder: (context, index) {

                final category = categories[index];

                final bool isSelected =
                    selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    _selectCategory(category);
                  },

                  child: AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 200),

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),

                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor
                          : Colors.white,

                      borderRadius:
                      BorderRadius.circular(25),

                      border: Border.all(
                        color: isSelected
                            ? primaryColor
                            : Colors.grey.shade200,
                      ),
                    ),

                    child: Text(
                      category,

                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : darkColor,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // ==================================================
          // POPULAR FOOD
          // ==================================================

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                'Popular near you',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),

              TextButton(
                onPressed: () {},

                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ==================================================
          // FOOD CARDS
          // ==================================================

          foodCard(
            'Cheese Burst Pizza',
            'Pizza • 25 min',
            '₹299',
            Icons.local_pizza,
          ),

          const SizedBox(height: 15),

          foodCard(
            'Chicken Biryani',
            'Biryani • 30 min',
            '₹249',
            Icons.rice_bowl,
          ),

          const SizedBox(height: 15),

          foodCard(
            'Classic Burger',
            'Burger • 20 min',
            '₹199',
            Icons.lunch_dining,
          ),

          const SizedBox(height: 30),

          // ==================================================
          // DELIVERY TYPE
          // DAY 4 - RADIO
          // ==================================================

          const Text(
            'Choose delivery speed',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Column(
              children: [

                RadioListTile<String>(
                  value: 'Standard',

                  groupValue: selectedDeliveryType,

                  activeColor: primaryColor,

                  title: const Text(
                    'Standard Delivery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  subtitle: const Text(
                    '30 - 45 minutes',
                  ),

                  onChanged: _selectDeliveryType,
                ),

                RadioListTile<String>(
                  value: 'Express',

                  groupValue: selectedDeliveryType,

                  activeColor: primaryColor,

                  title: const Text(
                    'Express Delivery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  subtitle: const Text(
                    '15 - 25 minutes',
                  ),

                  onChanged: _selectDeliveryType,
                ),

                RadioListTile<String>(
                  value: 'Priority',

                  groupValue: selectedDeliveryType,

                  activeColor: primaryColor,

                  title: const Text(
                    'Priority Delivery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  subtitle: const Text(
                    '10 - 15 minutes',
                  ),

                  onChanged: _selectDeliveryType,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // SELECTED DELIVERY
          // ==================================================

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: lightCoral,

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: Row(
              children: [

                const Icon(
                  Icons.delivery_dining,
                  color: primaryColor,
                  size: 30,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    '$selectedDeliveryType delivery selected',
                    style: const TextStyle(
                      color: darkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // TRACK DELIVERY
          // ==================================================

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              onPressed: () {

                ScaffoldMessenger.of(context)
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

              icon: const Icon(
                Icons.shopping_bag_outlined,
              ),

              label: const Text(
                'Order Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,

                foregroundColor: Colors.white,

                padding:
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // FOOD CARD
  // ==========================================================

  Widget foodCard(
      String name,
      String details,
      String price,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          // FOOD IMAGE PLACEHOLDER
          Container(
            width: 75,
            height: 75,

            decoration: BoxDecoration(
              color: lightCoral,

              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,

              size: 40,

              color: primaryColor,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  name,

                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  details,

                  style: const TextStyle(
                    fontSize: 13,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  price,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
              BorderRadius.circular(12),
            ),

            child: IconButton(
              onPressed: () {},

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