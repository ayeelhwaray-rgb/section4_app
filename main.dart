/*
Part 1 - State Lifecycle

a) When a page opens for the first time:
   initState(), didChangeDependencies(), and build() run.

b) After pressing the heart button:
   setState() calls build() again to update the UI.

c) When leaving a page:
   deactivate() runs, then dispose() if the page is permanently removed.
   When returning to a previous page, its build() may run again.

d) When resizing the browser:
   didChangeDependencies() runs because the screen size changes.
   build() runs again to update the layout.

Part 4 - Short Answers

1. context.go() navigates to a route and replaces the current location.
   Example: Login to Products using context.goNamed('products').
   context.push() adds a new page to the navigation stack.
   Example: Products to Details using context.pushNamed('details').

2. We use go for Login to Products because we don't need to keep
   Login as a page to return to. We use push for Product Details
   so the user can return to Products.

3. A path parameter is part of the URL path.
   Example: /details/Laptop/1200
   A query parameter comes after ? in the URL.
   Example: /products?user=Guest
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';
import 'login_page.dart';
import 'product_details_page.dart';

void main() {
  runApp(const ShoppingApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) {
        final username = state.uri.queryParameters['user'] ?? 'Guest';
        return HomePage(username: username);
      },
    ),
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) {
        final name = state.pathParameters['name']!;
        final price = double.parse(state.pathParameters['price']!);

        return ProductDetailsPage(
          product: {
            'name': name,
            'price': price,
            'isFavorite': false,
          },
        );
      },
    ),
  ],
);

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
    );
  }
}

/*
// Part 2: Navigation using Navigator (Old Implementation)

// Login to Products:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const HomePage(username: 'Guest'),
//   ),
// );

// Products to Details:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => ProductDetailsPage(
//       product: {
//         'name': 'Laptop',
//         'price': 1200.0,
//         'isFavorite': false,
//       },
//     ),
//   ),
// );

// Return to previous page:
// Navigator.pop(context);
*/