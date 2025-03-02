import 'dart:ui';

import 'package:fanta_prof/src/pages/login-signup/signup.page.dart';
import 'package:fanta_prof/src/pages/public/about.page.dart';
import 'package:fanta_prof/src/pages/reserved/classes.page.dart';
import 'package:fanta_prof/src/pages/login-signup/login.page.dart';
import 'package:fanta_prof/src/pages/reserved/settings.page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'package:go_router/go_router.dart';

import 'env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

main() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );
  supabase.auth.onAuthStateChange.listen((state) {
    _router.refresh();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      scrollBehavior: const ScrollBehavior(),
      title: 'FantaProf',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            (MediaQuery.of(context).platformBrightness == Brightness.light
                ? ColorSchemes.lightYellow()
                : ColorSchemes.darkYellow()),
        radius: 1,
        surfaceOpacity: 0.5,
        surfaceBlur: 20,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/about',
  redirect: (BuildContext context, GoRouterState state) async {
    print("test");

    final bool isLoggedIn = supabase.auth.currentUser != null;
    final bool isLogInOrSignUp = (state.matchedLocation == '/login' ||
        state.matchedLocation == '/signup');

    if (isLoggedIn) {
      print("isLoggedIn");
      if (!isLogInOrSignUp) {
        print("notLogInOrSignUp");
        return null;
      } else {
        print("wasLogInOrSignUp");
        return '/classes';
      }
    }
    if (isLogInOrSignUp) {
      print("isLogInOrSignUp");
      return state.path;
    } else {
      print("wasNotLogInOrSignUp");
      return '/about';
    }
  },
  routes: [
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) async {
        final bool isLoggedIn = supabase.auth.currentUser != null;

        if (isLoggedIn) {
          return '/classes';
        } else {
          return '/about';
        }
      },
    ),
    GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginPage();
        }),
    GoRoute(
        path: '/signup',
        builder: (context, state) {
          return SignUpPage();
        }),
    GoRoute(
        path: '/about',
        builder: (context, state) {
          return AboutPage();
        }),
    GoRoute(
        path: '/classes',
        builder: (context, state) {
          return ClassesPage();
        }),
    GoRoute(
        path: '/settings',
        builder: (context, state) {
          return SettingsPage();
        })
  ],
);
