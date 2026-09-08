import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_interests_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_intro_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/checkout/presentation/pages/add_payment_method_page.dart';
import '../../features/checkout/presentation/pages/checkout_payment_page.dart';
import '../../features/checkout/presentation/pages/checkout_shipping_page.dart';
import '../../features/checkout/presentation/pages/checkout_success_page.dart';
import '../pages/catalog_page.dart';
import '../pages/destination_page.dart';
import '../pages/home_page.dart';
import '../pages/product_detail_page.dart';
import '../widgets/app_shell.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: RouteNames.forgotPassword,
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        name: RouteNames.register,
        path: RoutePaths.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        name: RouteNames.onboardingIntro,
        path: RoutePaths.onboarding,
        builder: (context, state) => const OnboardingIntroPage(),
        routes: [
          GoRoute(
            name: RouteNames.onboardingInterests,
            path: RoutePaths.interests,
            builder: (context, state) => const OnboardingInterestsPage(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.home,
                path: RoutePaths.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.categories,
                path: RoutePaths.categories,
                builder: (context, state) =>
                    const DestinationPage(title: 'Categories'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.stores,
                path: RoutePaths.stores,
                builder: (context, state) =>
                    const DestinationPage(title: 'Stores'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.profile,
                path: RoutePaths.profile,
                builder: (context, state) =>
                    const DestinationPage(title: 'Profile'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.search,
        path: RoutePaths.search,
        builder: (context, state) => const DestinationPage(title: 'Search'),
      ),
      GoRoute(
        name: RouteNames.favorites,
        path: RoutePaths.favorites,
        builder: (context, state) => const DestinationPage(title: 'Favorites'),
      ),
      GoRoute(
        name: RouteNames.cart,
        path: RoutePaths.cart,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        name: RouteNames.catalog,
        path: RoutePaths.catalog,
        builder: (context, state) =>
            CatalogPage(section: state.uri.queryParameters['section']),
      ),
      GoRoute(
        name: RouteNames.productDetail,
        path: RoutePaths.productDetail,
        builder: (context, state) =>
            ProductDetailPage(productId: state.pathParameters['productId']!),
      ),
      GoRoute(
        name: RouteNames.checkoutShipping,
        path: RoutePaths.checkoutShipping,
        builder: (context, state) => const CheckoutShippingPage(),
      ),
      GoRoute(
        name: RouteNames.checkoutPayment,
        path: RoutePaths.checkoutPayment,
        builder: (context, state) => const CheckoutPaymentPage(),
      ),
      GoRoute(
        name: RouteNames.checkoutSuccess,
        path: RoutePaths.checkoutSuccess,
        builder: (context, state) => const CheckoutSuccessPage(),
      ),
      GoRoute(
        name: RouteNames.addPaymentMethod,
        path: RoutePaths.addPaymentMethod,
        builder: (context, state) => const AddPaymentMethodPage(),
      ),
    ],
  );
});
