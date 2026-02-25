import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/user_entity.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/role_selection_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/chef_reg_account_screen.dart';
import '../../features/auth/screens/chef_reg_documents_screen.dart';
import '../../features/auth/screens/chef_reg_success_screen.dart';
import '../../features/auth/screens/root_decider_screen.dart';
import '../../features/auth/screens/chef_rejection_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/cook/screens/home_screen.dart';
import '../../features/cook/screens/orders_screen.dart';
import '../../features/cook/screens/menu_screen.dart';
import '../../features/cook/screens/reels_screen.dart';
import '../../features/cook/screens/chat_screen.dart';
import '../../features/cook/screens/profile_screen.dart';
import '../../features/customer/naham_customer_screens.dart';
import '../constants/route_names.dart';

/// When true, app opens directly on chef home (no auth redirect). Set when user taps "I'm a Cook" on role selection.
final directCookEntryProvider = StateProvider<bool>((ref) => false);

final routerProvider = Provider<GoRouter>((ref) {
  final directCookEntry = ref.watch(directCookEntryProvider);

  return GoRouter(
    initialLocation: directCookEntry ? RouteNames.chefHome : RouteNames.splash,
    redirect: (context, state) {
      final path = state.uri.path;
      if (directCookEntry && path.startsWith('/chef')) return null;

      final auth = ref.read(authStateProvider);
      final isPublicRoute = path == RouteNames.splash ||
          path == RouteNames.onboarding ||
          path == RouteNames.roleSelection ||
          path == RouteNames.login ||
          path == RouteNames.signup ||
          path == RouteNames.rootDecider ||
          path.startsWith('/chef-registration') ||
          path == RouteNames.chefRejection;

      return auth.when(
        data: (UserEntity? user) {
          if (isPublicRoute) return null;
          if (user == null || user.role == null) return RouteNames.roleSelection;
          if (user.isChef) {
            if (path == RouteNames.chefRejection) return null;
            if (user.isChefRejected) return RouteNames.chefRejection;
            if (!user.isChefApproved) return RouteNames.roleSelection;
            if (path.startsWith('/customer')) return RouteNames.chefHome;
          }
          if (user.isCustomer && path.startsWith('/chef')) return RouteNames.customerRoot;
          if (user.isCustomer && path.startsWith('/customer') && path != RouteNames.customerRoot) return RouteNames.customerRoot;
          return null;
        },
        loading: () => null,
        error: (_, __) => path == RouteNames.splash ? null : RouteNames.roleSelection,
      );
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.roleSelection,
        builder: (_, __) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.signup,
        builder: (_, __) => const SignupScreen(),
      ),
      GoRoute(
        path: RouteNames.chefRegAccount,
        builder: (_, __) => const ChefRegAccountScreen(),
      ),
      GoRoute(
        path: RouteNames.chefRegDocuments,
        builder: (_, __) => const ChefRegDocumentsScreen(),
      ),
      GoRoute(
        path: RouteNames.chefRegSuccess,
        builder: (_, __) => const ChefRegSuccessScreen(),
      ),
      GoRoute(
        path: RouteNames.rootDecider,
        builder: (_, __) => const RootDeciderScreen(),
      ),
      GoRoute(
        path: RouteNames.chefRejection,
        builder: (_, __) => const ChefRejectionScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => ChefShell(
          child: child,
          currentLocation: state.uri.path,
        ),
        routes: [
          GoRoute(path: RouteNames.chefHome, builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouteNames.chefOrders, builder: (_, __) => const OrdersScreen()),
          GoRoute(path: RouteNames.chefMenu, builder: (_, __) => const MenuScreen()),
          GoRoute(path: RouteNames.chefReels, builder: (_, __) => const ReelsScreen()),
          GoRoute(path: RouteNames.chefChat, builder: (_, __) => const ChatScreen()),
          GoRoute(path: RouteNames.chefProfile, builder: (_, __) => const ProfileScreen()),
        ],
      ),
      GoRoute(
        path: RouteNames.customerRoot,
        builder: (_, __) => const MainNavigationScreen(),
      ),
    ],
  );
});

class ChefShell extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  const ChefShell({super.key, required this.child, required this.currentLocation});

  int _index(String path) {
    if (path.startsWith(RouteNames.chefHome)) return 0;
    if (path.startsWith(RouteNames.chefOrders)) return 1;
    if (path.startsWith(RouteNames.chefMenu)) return 2;
    if (path.startsWith(RouteNames.chefReels)) return 3;
    if (path.startsWith(RouteNames.chefChat)) return 4;
    if (path.startsWith(RouteNames.chefProfile)) return 5;
    return 0;
  }

  static const _selectedColor = Color(0xFF7B5EA7);
  static const _unselectedColor = Color(0xFF6B7280);
  static const _navBg = Color(0xFFC4B0E8);

  @override
  Widget build(BuildContext context) {
    final currentIndex = _index(currentLocation);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _navBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) {
            switch (i) {
              case 0: context.go(RouteNames.chefHome); break;
              case 1: context.go(RouteNames.chefOrders); break;
              case 2: context.go(RouteNames.chefMenu); break;
              case 3: context.go(RouteNames.chefReels); break;
              case 4: context.go(RouteNames.chefChat); break;
              case 5: context.go(RouteNames.chefProfile); break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: _selectedColor,
          unselectedItemColor: _unselectedColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_outlined), activeIcon: Icon(Icons.restaurant_menu_rounded), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline_rounded), activeIcon: Icon(Icons.play_circle_rounded), label: 'Reels'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), activeIcon: Icon(Icons.chat_bubble_rounded), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
