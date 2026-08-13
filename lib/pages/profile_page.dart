import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const Color primaryColor =
  Color(0xFFFF5A5F);

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final theme =
    Theme.of(context);

    final colors =
        theme.colorScheme;

    final user =
    ref.watch(userProvider);

    final isDarkMode =
        ref.watch(themeProvider) ==
            ThemeMode.dark;

    return Scaffold(
      backgroundColor:
      theme.scaffoldBackgroundColor,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor:
        primaryColor,

        foregroundColor:
        Colors.white,

        elevation: 0,

        title: const Text(
          'My Profile',

          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            // ==================================================
            // PROFILE IMAGE
            // ==================================================

            Container(
              width: 110,
              height: 110,

              decoration:
              BoxDecoration(
                shape:
                BoxShape.circle,

                color:
                primaryColor,

                boxShadow: [
                  BoxShadow(
                    color: primaryColor
                        .withValues(
                      alpha: 0.25,
                    ),

                    blurRadius: 15,

                    offset:
                    const Offset(
                      0,
                      6,
                    ),
                  ),
                ],
              ),

              child: const Icon(
                Icons.person,

                size: 60,

                color: Colors.white,
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            // ==================================================
            // USER NAME
            // ==================================================

            Text(
              user.name,

              textAlign:
              TextAlign.center,

              style: TextStyle(
                fontSize: 25,

                fontWeight:
                FontWeight.bold,

                color:
                colors.onSurface,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // ==================================================
            // USER EMAIL
            // ==================================================

            Text(
              user.email,

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
              height: 15,
            ),

            // ==================================================
            // EDIT PROFILE BUTTON
            // ==================================================

            OutlinedButton.icon(
              onPressed: () {
                _showEditProfileDialog(
                  context,
                  ref,
                  user.name,
                  user.email,
                );
              },

              icon: const Icon(
                Icons.edit_outlined,
              ),

              label: const Text(
                'Edit Profile',
              ),

              style:
              OutlinedButton.styleFrom(
                foregroundColor:
                primaryColor,

                side:
                const BorderSide(
                  color:
                  primaryColor,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // ==================================================
            // PROFILE OPTIONS
            // ==================================================

            _profileOption(
              context,
              Icons.person_outline,
              'Personal Information',
                  () {
                _showEditProfileDialog(
                  context,
                  ref,
                  user.name,
                  user.email,
                );
              },
            ),

            _profileOption(
              context,
              Icons.location_on_outlined,
              'Saved Addresses',
                  () {},
            ),

            _profileOption(
              context,
              Icons.notifications_none,
              'Notifications',
                  () {},
            ),

            // ==================================================
            // DARK MODE
            // ==================================================

            Container(
              width:
              double.infinity,

              margin:
              const EdgeInsets.only(
                bottom: 12,
              ),

              decoration:
              BoxDecoration(
                color:
                colors.surface,

                borderRadius:
                BorderRadius.circular(
                  15,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(
                      alpha:
                      theme.brightness ==
                          Brightness.dark
                          ? 0.25
                          : 0.06,
                    ),

                    blurRadius: 7,

                    offset:
                    const Offset(
                      0,
                      3,
                    ),
                  ),
                ],
              ),

              child:
              SwitchListTile(
                secondary: Icon(
                  isDarkMode
                      ? Icons.dark_mode
                      : Icons.light_mode,

                  color:
                  primaryColor,
                ),

                title: Text(
                  'Dark Mode',

                  style: TextStyle(
                    color:
                    colors.onSurface,

                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                subtitle: Text(
                  isDarkMode
                      ? 'Dark theme enabled'
                      : 'Light theme enabled',

                  style: TextStyle(
                    color: colors
                        .onSurface
                        .withValues(
                      alpha: 0.6,
                    ),
                  ),
                ),

                value:
                isDarkMode,

                activeThumbColor:
                primaryColor,

                onChanged:
                    (value) {
                  ref
                      .read(
                    themeProvider
                        .notifier,
                  )
                      .toggleTheme();
                },
              ),
            ),

            _profileOption(
              context,
              Icons.settings_outlined,
              'Settings',
                  () {},
            ),

            _profileOption(
              context,
              Icons.help_outline,
              'Help & Support',
                  () {},
            ),

            // ==================================================
            // LOGOUT
            // ==================================================

            _profileOption(
              context,
              Icons.logout,
              'Logout',
                  () {
                _showLogoutDialog(
                  context,
                  ref,
                );
              },
              isLogout: true,
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              'Droply • Food delivered with love ❤️',

              style: TextStyle(
                fontSize: 12,

                color: colors
                    .onSurface
                    .withValues(
                  alpha: 0.45,
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE OPTION
  // ==========================================================

  static Widget _profileOption(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap, {
        bool isLogout = false,
      }) {
    final colors =
        Theme.of(context)
            .colorScheme;

    return Container(
      width:
      double.infinity,

      margin:
      const EdgeInsets.only(
        bottom: 12,
      ),

      decoration:
      BoxDecoration(
        color:
        colors.surface,

        borderRadius:
        BorderRadius.circular(
          15,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(
              alpha:
              Theme.of(context)
                  .brightness ==
                  Brightness.dark
                  ? 0.25
                  : 0.06,
            ),

            blurRadius: 7,

            offset:
            const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,

          color: isLogout
              ? Colors.red
              : primaryColor,
        ),

        title: Text(
          title,

          style: TextStyle(
            color: isLogout
                ? Colors.red
                : colors.onSurface,

            fontWeight:
            FontWeight.w600,
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,

          size: 16,

          color: colors
              .onSurface
              .withValues(
            alpha: 0.45,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EDIT PROFILE DIALOG
  // ==========================================================

  static void _showEditProfileDialog(
      BuildContext context,
      WidgetRef ref,
      String currentName,
      String currentEmail,
      ) {
    final nameController =
    TextEditingController(
      text: currentName,
    );

    final emailController =
    TextEditingController(
      text: currentEmail,
    );

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
          ),

          content:
          SingleChildScrollView(
            child: Column(
              mainAxisSize:
              MainAxisSize.min,

              children: [
                TextField(
                  controller:
                  nameController,

                  textCapitalization:
                  TextCapitalization
                      .words,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Name',

                    prefixIcon:
                    Icon(
                      Icons.person_outline,
                    ),

                    border:
                    OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                TextField(
                  controller:
                  emailController,

                  keyboardType:
                  TextInputType
                      .emailAddress,

                  decoration:
                  const InputDecoration(
                    labelText:
                    'Email',

                    prefixIcon:
                    Icon(
                      Icons.email_outlined,
                    ),

                    border:
                    OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                final name =
                nameController.text
                    .trim();

                final email =
                emailController.text
                    .trim();

                if (name.isEmpty ||
                    email.isEmpty) {
                  ScaffoldMessenger
                      .of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter name and email',
                      ),

                      backgroundColor:
                      primaryColor,
                    ),
                  );

                  return;
                }

                await ref
                    .read(
                  userProvider
                      .notifier,
                )
                    .saveUser(
                  name: name,
                  email: email,
                );

                if (!dialogContext
                    .mounted) {
                  return;
                }

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile updated successfully',
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
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // LOGOUT DIALOG
  // ==========================================================

  static void _showLogoutDialog(
      BuildContext context,
      WidgetRef ref,
      ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.logout,

            color:
            primaryColor,

            size: 40,
          ),

          title: const Text(
            'Logout?',
          ),

          content: const Text(
            'Do you want to remove your saved profile details?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(
                  userProvider
                      .notifier,
                )
                    .logout();

                if (!dialogContext
                    .mounted) {
                  return;
                }

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile details cleared',
                    ),

                    backgroundColor:
                    primaryColor,
                  ),
                );
              },

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                Colors.red,

                foregroundColor:
                Colors.white,
              ),

              child:
              const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );
  }
}