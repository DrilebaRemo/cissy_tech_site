import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_page.dart';
import '../../features/collecto/collecto_page.dart';
import '../../features/company/company_info.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/collecto',
      builder: (context, state) => const CollectoPage(),
    ),
    GoRoute(
      path: '/company',
      builder: (context, state) => const CompanyInfoPage(),
    ),
  ],
);
