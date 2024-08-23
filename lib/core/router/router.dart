import 'package:devti_agro/features/Checklist/presontation/screens/Checklist.dart';
import 'package:devti_agro/features/Etiquetage/presontation/screens/Etiquetage.dart';
import 'package:devti_agro/features/Etiquetage/presontation/screens/create_equetage.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/Chambres.dart';
import 'package:devti_agro/features/chambre/presontaion/Chambres/CreateChambre.dart';
import 'package:devti_agro/features/Checklist/presontation/screens/create_Checklist.dart';
import 'package:devti_agro/features/dashboard/presentation/screens/HomePage.dart';
import 'package:devti_agro/features/dashboard/presentation/screens/Nettoyage/Nettoyage.dart';
import 'package:devti_agro/features/dashboard/presentation/screens/Nettoyage/create_nettoyage.dart';
import 'package:devti_agro/features/dashboard/presentation/screens/Temperature/Temperature.dart';
import 'package:devti_agro/features/dashboard/presentation/screens/Temperature/create_Temperature.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/screens/Tracbalite.dart';
import 'package:devti_agro/features/Tracbalite/presentaion/screens/create_tracbalite.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'routes.dart';

// custom transition config
CustomTransitionPage _buildCustomTransition(
  context,
  state,
  child, {
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

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: AppRoutes.homePage,
  routes: [
    // GoRoute(
    //   path: AppRoutes.onboarding,
    //   name: AppRoutes.onboardingNamed,
    //   pageBuilder: (context, state) => _buildCustomTransition(context, state, OnboardingScreen()),
    // ),
    // routes.dart or wherever your routes are defined

    GoRoute(
      path: AppRoutes.homePage, // This should be '/'
      name: AppRoutes.homePage,
      pageBuilder: (context, state) => _buildCustomTransition(context, state, const Homepage()),
    ),

    GoRoute(
      path: AppRoutes.chambres,
      name: AppRoutes.chambresNamed,
      pageBuilder: (context, state) => _buildCustomTransition(context, state, const ChambreWidget()),
      routes: [
        GoRoute(
          path: AppRoutes.chambresCreate,
          name: AppRoutes.chambresCreateNamed,
          pageBuilder: (context, state) => _buildCustomTransition(context, state, Createchambre(), slideRight: true),
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
      pageBuilder: (context, state) => _buildCustomTransition(context, state, const Temperature()),
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
  ],
);
