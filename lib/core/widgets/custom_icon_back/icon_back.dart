import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class IconBack extends StatelessWidget {
  const IconBack({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current locale from the context
    final currentLocale = Localizations.localeOf(context);

    // Check if the current locale is Arabic
    final isArabic = currentLocale.languageCode == 'ar';

    return Icon(
      isArabic ? Ionicons.chevron_forward_outline : Ionicons.chevron_back_outline,
      color: Theme.of(context).iconTheme.color,
    );
  }
}
