import 'package:flutter/material.dart';
import 'package:frontend/core/theme/library_shelf_theme.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:get/get.dart';
import 'package:frontend/routes/app_pages.dart';

enum LibraryNavItem { library, search, reader, downloads, profile }

class LibraryBottomNav extends StatelessWidget {
  const LibraryBottomNav({
    super.key,
    required this.current,
    required this.onSearch,
    required this.onContinueReading,
    required this.onUpload,
  });

  final LibraryNavItem current;
  final VoidCallback onSearch;
  final VoidCallback onContinueReading;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: LibraryShelfTheme.woodDark.withValues(alpha: 0.96),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.auto_stories_rounded,
                label: 'Library',
                selected: current == LibraryNavItem.library,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.search_rounded,
                label: 'Search',
                selected: current == LibraryNavItem.search,
                onTap: onSearch,
              ),
              _NavItem(
                icon: Icons.menu_book_rounded,
                label: 'Reader',
                selected: current == LibraryNavItem.reader,
                onTap: onContinueReading,
              ),
              _NavItem(
                icon: Icons.download_rounded,
                label: 'Downloads',
                selected: current == LibraryNavItem.downloads,
                onTap: onUpload,
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                selected: current == LibraryNavItem.profile,
                onTap: () {
                  AppHaptics.light();
                  Get.toNamed(AppRoutes.about);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? LibraryShelfTheme.navActive : LibraryShelfTheme.navInactive;

    return InkWell(
      onTap: () {
        AppHaptics.light();
        onTap();
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
