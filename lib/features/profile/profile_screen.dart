import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primary,
            ),

            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 50,
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // =================================================
                  // PROFILE IMAGE
                  // =================================================

                  Container(
                    width: 58,
                    height: 58,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      border: Border.all(
                        color: colorScheme.onPrimary,
                        width: 2,
                      ),

                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/jpg/images/burger_image.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // =================================================
                  // NAME + EMAIL
                  // =================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 5),

                        Text(
                          'Sajid Ali',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'sajidali@gmail.com',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(.85),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =================================================
                  // SETTINGS
                  // =================================================

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings_outlined,
                      color: colorScheme.onPrimary,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =========================================================
          // MENU CARD
          // =========================================================

          Positioned(
            top: 130,
            left: 0,
            right: 0,
            bottom: 0,

            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,

                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),

                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                child: Column(
                  children: [

                    // =================================================
                    // MENU ITEMS
                    // =================================================

                    _menuItem(
                      context: context,
                      icon: Icons.location_on_outlined,
                      title: 'My Addresses',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.favorite_border,
                      title: 'My Favorites',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),

                    _menuItem(
                      context: context,
                      icon: Icons.info_outline,
                      title: 'About Us',
                      onTap: () {},
                    ),

                    const SizedBox(height: 10),

                    // =================================================
                    // DIVIDER
                    // =================================================

                    Divider(
                      color: colorScheme.onSurface.withOpacity(.10),
                      height: 1,
                    ),

                    const SizedBox(height: 5),

                    // =================================================
                    // LOGOUT
                    // =================================================

                    InkWell(
                      borderRadius: BorderRadius.circular(10),

                      onTap: () {
                        // logout
                      },

                      child: SizedBox(
                        height: 50,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),

                          child: Row(
                            children: [

                              Icon(
                                Icons.logout,
                                size: 21,
                                color: colorScheme.primary,
                              ),

                              const SizedBox(width: 14),

                              Text(
                                'Logout',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // MENU ITEM
  // ================================================================

  static Widget _menuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),

      onTap: onTap,

      child: Container(
        height: 55,

        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),

        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.onSurface.withOpacity(.10),
              width: .7,
            ),
          ),
        ),

        child: Row(
          children: [

            // ========================================================
            // ICON
            // ========================================================

            Icon(
              icon,
              size: 21,
              color: colorScheme.onSurface.withOpacity(.75),
            ),

            const SizedBox(width: 14),

            // ========================================================
            // TITLE
            // ========================================================

            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // ========================================================
            // ARROW
            // ========================================================

            Icon(
              Icons.chevron_right,
              size: 21,
              color: colorScheme.onSurface.withOpacity(.45),
            ),
          ],
        ),
      ),
    );
  }
}