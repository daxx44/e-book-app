import 'package:flutter/material.dart';
import 'package:frontend/core/theme/reader_theme.dart';

class ReaderProgressFooter extends StatelessWidget {
  const ReaderProgressFooter({
    super.key,
    required this.currentLabel,
    required this.progress,
    required this.percentText,
  });

  final String currentLabel;
  final double progress;
  final String percentText;

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Material(
      color: ReaderTheme.footerBackground,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('PROGRESS', style: ReaderTheme.footerLabelStyle),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      currentLabel,
                      style: ReaderTheme.footerPageStyle,
                    ),
                  ),
                  Text(percentText, style: ReaderTheme.footerPercentStyle),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: clampedProgress,
                  minHeight: 4,
                  backgroundColor: ReaderTheme.progressTrack,
                  color: ReaderTheme.progressFill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
