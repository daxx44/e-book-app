import 'package:flutter/material.dart';
import 'package:frontend/controllers/dashboard_controller.dart';
import 'package:frontend/core/constants/about_info.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/utils/app_haptics.dart';
import 'package:frontend/routes/app_pages.dart';
import 'package:frontend/widgets/app_icon.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(AppSpacing.radiusXl)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Row(
                children: [
                  const AppIcon(size: 48, borderRadius: 14),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AboutInfo.appTitle, style: Theme.of(context).textTheme.titleMedium),
                        Text('v${AboutInfo.version}', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            _DrawerTile(
              icon: Icons.library_books_outlined,
              label: 'My Library',
              selected: Get.isRegistered<DashboardController>() &&
                  Get.find<DashboardController>().currentIndex.value ==
                      DashboardController.tabLibrary,
              onTap: () {
                AppHaptics.selection();
                Navigator.pop(context);
                if (Get.isRegistered<DashboardController>()) {
                  Get.find<DashboardController>().selectTab(DashboardController.tabLibrary);
                }
              },
            ),
            _DrawerTile(
              icon: Icons.upload_file_rounded,
              label: 'Upload Ebook',
              onTap: () {
                AppHaptics.light();
                Navigator.pop(context);
                Get.toNamed(AppRoutes.upload);
              },
            ),
            _DrawerTile(
              icon: Icons.search_rounded,
              label: 'Search',
              onTap: () {
                AppHaptics.light();
                Navigator.pop(context);
                Get.toNamed(AppRoutes.search);
              },
            ),
            _DrawerTile(
              icon: Icons.info_outline_rounded,
              label: 'About',
              selected: Get.isRegistered<DashboardController>() &&
                  Get.find<DashboardController>().currentIndex.value ==
                      DashboardController.tabAbout,
              onTap: () {
                AppHaptics.light();
                Navigator.pop(context);
                if (Get.isRegistered<DashboardController>()) {
                  Get.find<DashboardController>().selectTab(DashboardController.tabAbout);
                }
              },
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Designed & Developed by', style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 6),
                  Text(AboutInfo.developerName, style: Theme.of(context).textTheme.titleSmall),
                  Text(AboutInfo.developerRole, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 12),
                  Text(
                    'Built with Flutter ❤️ Ruby on Rails',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.accent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? AppColors.accent : AppColors.textSecondary),
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: selected ? AppColors.primary : AppColors.textPrimary,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
      ),
      selected: selected,
      selectedTileColor: AppColors.accent.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      onTap: onTap,
    );
  }
}
