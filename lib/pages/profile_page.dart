import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  // ==========================================================
  // DARK MODE - RECEIVED FROM MAIN.DART
  // ==========================================================

  final bool isDarkMode;

  final ValueChanged<bool> onDarkModeChanged;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryColor = Color(0xFFFF5A5F);

  static const Color darkColor = Color(0xFF202124);

  static const Color creamColor = Color(0xFFFFF8F3);

  static const Color lightCoral = Color(0xFFFFE8E8);

  static const Color textColor = Color(0xFF555555);

  // ==========================================================
  // DAY 4 - STATE VARIABLES
  // ==========================================================

  bool notificationsEnabled = true;

  bool saveDeliveryHistory = true;

  bool promotionalNotifications = false;

  double notificationVolume = 60;

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {

    final bool darkMode = widget.isDarkMode;

    final Color backgroundColor =
    darkMode
        ? const Color(0xFF121212)
        : creamColor;

    final Color cardColor =
    darkMode
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    final Color headingColor =
    darkMode
        ? Colors.white
        : darkColor;

    final Color bodyTextColor =
    darkMode
        ? Colors.white70
        : textColor;

    return Scaffold(
      backgroundColor: backgroundColor,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: primaryColor,

        elevation: 0,

        title: const Text(
          'My Profile',
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
              Icons.edit_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // ======================================================
      // PROFILE CONTENT
      // ======================================================

      body: ListView(
        physics: const ClampingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        children: [

          // ==================================================
          // PROFILE HEADER
          // ==================================================

          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: cardColor,

              borderRadius:
              BorderRadius.circular(22),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    darkMode ? 0.3 : 0.05,
                  ),

                  blurRadius: 10,

                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              children: [

                // PROFILE IMAGE
                Container(
                  width: 105,
                  height: 105,

                  decoration: BoxDecoration(
                    color: lightCoral,

                    shape: BoxShape.circle,

                    border: Border.all(
                      color: primaryColor,
                      width: 3,
                    ),
                  ),

                  child: const Icon(
                    Icons.person,
                    size: 62,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'Ananya R',

                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: headingColor,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'ananya@example.com',

                  style: TextStyle(
                    fontSize: 15,
                    color: bodyTextColor,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: lightCoral,

                    borderRadius:
                    BorderRadius.circular(20),
                  ),

                  child: const Text(
                    'Food Lover 🍔',

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

          const SizedBox(height: 28),

          // ==================================================
          // ACCOUNT
          // ==================================================

          Text(
            'Account',

            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          profileOption(
            Icons.person_outline,
            'Personal Information',
            'Update your name and email',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          profileOption(
            Icons.location_on_outlined,
            'Saved Addresses',
            'Manage your delivery locations',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          profileOption(
            Icons.payment_outlined,
            'Payment Methods',
            'Manage cards and payment options',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          const SizedBox(height: 28),

          // ==================================================
          // NOTIFICATION SETTINGS
          // ==================================================

          Text(
            'Notifications',

            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: cardColor,

              borderRadius:
              BorderRadius.circular(20),
            ),

            child: Column(
              children: [

                // ==================================================
                // ORDER NOTIFICATIONS - SWITCH
                // ==================================================

                SwitchListTile(
                  value: notificationsEnabled,

                  activeColor: primaryColor,

                  title: Text(
                    'Order Notifications',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: headingColor,
                    ),
                  ),

                  subtitle: Text(
                    'Get updates about your orders',

                    style: TextStyle(
                      color: bodyTextColor,
                    ),
                  ),

                  secondary: const Icon(
                    Icons.notifications_none,
                    color: primaryColor,
                  ),

                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),

                const Divider(
                  height: 1,
                ),

                // ==================================================
                // DELIVERY HISTORY - CHECKBOX
                // ==================================================

                CheckboxListTile(
                  value: saveDeliveryHistory,

                  activeColor: primaryColor,

                  title: Text(
                    'Save Delivery History',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: headingColor,
                    ),
                  ),

                  subtitle: Text(
                    'Keep your previous orders available',

                    style: TextStyle(
                      color: bodyTextColor,
                    ),
                  ),

                  secondary: const Icon(
                    Icons.history,
                    color: primaryColor,
                  ),

                  onChanged: (value) {
                    setState(() {
                      saveDeliveryHistory =
                          value ?? false;
                    });
                  },
                ),

                const Divider(
                  height: 1,
                ),

                // ==================================================
                // PROMOTIONS - CHECKBOX
                // ==================================================

                CheckboxListTile(
                  value: promotionalNotifications,

                  activeColor: primaryColor,

                  title: Text(
                    'Offers & Promotions',

                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: headingColor,
                    ),
                  ),

                  subtitle: Text(
                    'Receive discounts and special offers',

                    style: TextStyle(
                      color: bodyTextColor,
                    ),
                  ),

                  secondary: const Icon(
                    Icons.local_offer_outlined,
                    color: primaryColor,
                  ),

                  onChanged: (value) {
                    setState(() {
                      promotionalNotifications =
                          value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ==================================================
          // NOTIFICATION VOLUME
          // ==================================================

          Text(
            'Notification Sound',

            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: cardColor,

              borderRadius:
              BorderRadius.circular(20),
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    const Icon(
                      Icons.volume_up_outlined,
                      color: primaryColor,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        'Volume',

                        style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          color: headingColor,
                        ),
                      ),
                    ),

                    Text(
                      '${notificationVolume.round()}%',

                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ==================================================
                // SLIDER
                // ==================================================

                Slider(
                  value: notificationVolume,

                  min: 0,

                  max: 100,

                  divisions: 10,

                  activeColor: primaryColor,

                  inactiveColor: lightCoral,

                  label:
                  '${notificationVolume.round()}%',

                  onChanged: (value) {
                    setState(() {
                      notificationVolume = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ==================================================
          // MORE
          // ==================================================

          Text(
            'More',

            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: headingColor,
            ),
          ),

          const SizedBox(height: 12),

          // ==================================================
          // DARK MODE
          // ==================================================

          Container(
            margin:
            const EdgeInsets.only(bottom: 12),

            decoration: BoxDecoration(
              color: cardColor,

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: SwitchListTile(
              value: widget.isDarkMode,

              activeColor: primaryColor,

              secondary: Icon(
                widget.isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,

                color: primaryColor,
              ),

              title: Text(
                'Dark Mode',

                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: headingColor,
                ),
              ),

              subtitle: Text(
                widget.isDarkMode
                    ? 'Dark mode is enabled'
                    : 'Use light mode',

                style: TextStyle(
                  color: bodyTextColor,
                ),
              ),

              onChanged: (value) {
                widget.onDarkModeChanged(value);
              },
            ),
          ),

          // ==================================================
          // SETTINGS
          // ==================================================

          profileOption(
            Icons.settings_outlined,
            'Settings',
            'Manage app preferences',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          // ==================================================
          // HELP
          // ==================================================

          profileOption(
            Icons.help_outline,
            'Help & Support',
            'Get help with your orders',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          // ==================================================
          // ABOUT
          // ==================================================

          profileOption(
            Icons.info_outline,
            'About Droply',
            'Version 1.0.0',
            cardColor,
            headingColor,
            bodyTextColor,
          ),

          const SizedBox(height: 15),

          // ==================================================
          // LOGOUT
          // ==================================================

          Container(
            decoration: BoxDecoration(
              color: cardColor,

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),

              title: const Text(
                'Logout',

                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),

              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logout clicked',
                    ),
                    backgroundColor:
                    primaryColor,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE OPTION
  // ==========================================================

  Widget profileOption(
      IconData icon,
      String title,
      String subtitle,
      Color cardColor,
      Color headingColor,
      Color bodyTextColor,
      ) {
    return Container(
      margin:
      const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.04),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),

        leading: Container(
          width: 45,
          height: 45,

          decoration: BoxDecoration(
            color: lightCoral,

            borderRadius:
            BorderRadius.circular(13),
          ),

          child: Icon(
            icon,
            color: primaryColor,
          ),
        ),

        title: Text(
          title,

          style: TextStyle(
            color: headingColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: TextStyle(
            color: bodyTextColor,
            fontSize: 12,
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color:
          widget.isDarkMode
              ? Colors.white54
              : Colors.grey,
        ),

        onTap: () {},
      ),
    );
  }
}