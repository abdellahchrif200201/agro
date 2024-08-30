import 'package:devti_agro/core/router/routes.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/Checklist.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/create_Checklist.dart';
import 'package:devti_agro/features/Etiquetage/presontation/screens/Etiquetage.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/screens/create_tracbalite.dart';
import 'package:devti_agro/features/auth/login/presontaion/screens/login_screen.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/Chambres.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/CreateChambre.dart';
import 'package:devti_agro/features/dashboard/HomePage.dart';
import 'package:devti_agro/features/Nettoyage/Nettoyage.dart';
import 'package:devti_agro/features/Nettoyage/create_nettoyage.dart';
import 'package:devti_agro/features/Temperature/create_Temperature.dart';
import 'package:devti_agro/features/nutrition/presentaion/screens/nutrition_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/account_screen.dart.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/add_user_screen.dart';
import 'package:devti_agro/features/profile/prsentaion/screens/all_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/Etiquetage/presontation/screens/create_equetage.dart';
import '../../features/Tracbalite/presentaion/screens/Tracbalite.dart';

// Import your other screens and widgets here
// ...

CustomTransitionPage _buildCustomTransition(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  bool slideRight = false,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      if (slideRight) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}

GoRouter appRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        path: AppRoutes.homePage,
        name: AppRoutes.homePageNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, Homepage()),
      ),

      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, Homepage()),
      ),

      GoRoute(
        path: AppRoutes.chambres,
        name: AppRoutes.chambresNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const ChambreWidget()),
        routes: [
          GoRoute(
            path: AppRoutes.chambresCreate,
            name: AppRoutes.chambresCreateNamed,
            pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateChambre(), slideRight: true),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.traceability,
        name: AppRoutes.traceabilityNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const Tracbalite()),
        routes: [
          GoRoute(
            path: AppRoutes.traceabilityCreate,
            name: AppRoutes.traceabilityCreateNamed,
            pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateTracbalite(), slideRight: true),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.temperature,
        name: AppRoutes.temperatureNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const NutritionScreen()),
        routes: [
          GoRoute(
            path: AppRoutes.temperatureCreate,
            name: AppRoutes.temperatureCreate,
            pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateTemperature(), slideRight: true),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.nettoyage,
        name: AppRoutes.nettoyageNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const Nettoyage()),
        routes: [
          GoRoute(
            path: AppRoutes.nettoyageCreate,
            name: AppRoutes.nettoyageCreateNamed,
            pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateNettoyage(), slideRight: true),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.checklist,
        name: AppRoutes.checklistNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const ChecklistScreen()),
        routes: [
          GoRoute(path: AppRoutes.checklistCreate, name: AppRoutes.checklistCreateNamed, pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateChecklist(), slideRight: true)),
        ],
      ),
      GoRoute(
        path: AppRoutes.etiquetage,
        name: AppRoutes.etiquetageNamed,
        pageBuilder: (context, state) => _buildCustomTransition(context, state, const Etiquetage()),
        routes: [
          GoRoute(path: AppRoutes.etiquetageCreate, name: AppRoutes.etiquetageCreateNamed, pageBuilder: (context, state) => _buildCustomTransition(context, state, CreateEquetage(), slideRight: true)),
        ],
      ),
      // Define other routes here...
    ],
  );
}
