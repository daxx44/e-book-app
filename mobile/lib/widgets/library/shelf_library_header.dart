import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/core/constants/app_spacing.dart';
import 'package:frontend/core/theme/library_shelf_theme.dart';

class ShelfLibraryHeader extends StatelessWidget {
  const ShelfLibraryHeader({
    super.key,
    required this.bookCount,
    required this.onSearch,
    required this.onMenu,
    required this.sortMenu,
  });

  final int bookCount;
  final VoidCallback onSearch;
  final VoidCallback onMenu;
  final Widget sortMenu;

  String get _countLabel {
    if (bookCount == 0) return '0 Books';
    if (bookCount == 1) return '1 Book';
    return '$bookCount Books';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          MediaQuery.paddingOf(context).top + AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShelfHeaderIcon(icon: Icons.menu_rounded, onPressed: onMenu),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Library',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: LibraryShelfTheme.headerText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _countLabel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: LibraryShelfTheme.headerMuted,
                    ),
                  ),
                ],
              ),
            ),
            _ShelfHeaderIcon(icon: Icons.search_rounded, onPressed: onSearch),
            const SizedBox(width: AppSpacing.sm),
            sortMenu,
          ],
        ),
      ),
    );
  }
}

class _ShelfHeaderIcon extends StatelessWidget {
  const _ShelfHeaderIcon({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: LibraryShelfTheme.headerText, size: 22),
        ),
      ),
    );
  }
}
