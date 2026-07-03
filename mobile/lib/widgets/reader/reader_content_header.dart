import 'package:flutter/material.dart';
import 'package:frontend/core/theme/reader_theme.dart';

class ReaderContentHeader extends StatelessWidget {
  const ReaderContentHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: ReaderTheme.titleSerif,
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              subtitle!.toUpperCase(),
              textAlign: TextAlign.center,
              style: ReaderTheme.chapterLabelStyle,
            ),
          ],
        ],
      ),
    );
  }
}
