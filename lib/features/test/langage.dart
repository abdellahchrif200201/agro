import 'package:devti_agro/core/lang/bloc/language_bloc.dart';
import 'package:devti_agro/core/widgets/custom_icon_back/icon_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        final currentLocale = (state is LanguageChangedState) ? state.locale : Locale('fr');

        // Define language options
        final languageOptions = [
          Locale('en'),
          Locale('fr'),
          Locale('ar'),
        ];

        // Define labels for the languages
        final languageLabels = {
          Locale('en'): 'English',
          Locale('fr'): 'Français',
          Locale('ar'): 'عربي',
        };

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconBack(),
            ),
            leadingWidth: 80,
          ),
          body: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: languageOptions.map((locale) {
                return GestureDetector(
                  onTap: () async {
                    context.read<LanguageBloc>().add(SetLocaleEvent(locale));
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('selectedLocale', locale.languageCode);
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: locale == currentLocale ? Colors.green : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      languageLabels[locale]!,
                      style: TextStyle(color: locale == currentLocale ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}





// import 'dart:ui';

// import 'package:devti_agro/core/lang/bloc/language_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageDropdown extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LanguageBloc, LanguageState>(
//       builder: (context, state) {
//         final currentLocale = (state is LanguageChangedState) ? state.locale : Locale('fr');
//         return DropdownButton<Locale>(
//           value: currentLocale,
//           onChanged: (Locale? newLocale) {
//             if (newLocale != null) {
//               context.read<LanguageBloc>().add(SetLocaleEvent(newLocale));
//               // Also update SharedPreferences directly here if needed
//               SharedPreferences.getInstance().then((prefs) {
//                 prefs.setString('selectedLocale', newLocale.languageCode);
//               });
//             }
//           },
//           items: [
//             DropdownMenuItem(
//               value: Locale('en'),
//               child: Text('English'),
//             ),
//             DropdownMenuItem(
//               value: Locale('fr'),
//               child: Text('Français'),
//             ),
//             DropdownMenuItem(
//               value: Locale('ar'),
//               child: Text('عربي'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
