import 'package:flutter/material.dart';
import 'product_widgets.dart';

class NavigatorApp extends StatelessWidget {
  const NavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      initialRoute: '/',
      routes: {
        '/': (context) => const NavigatorLoginPage(),
        '/products': (context) {
          final username =
          ModalRoute.of(context)!.settings.arguments as String;

          return NavigatorProductsPage(username: username);
        },
      },
    );
  }
}

class NavigatorLoginPage extends StatefulWidget {
  const NavigatorLoginPage({super.key});

  @override
  State<NavigatorLoginPage> createState() =>
      _NavigatorLoginPageState();
}

class _NavigatorLoginPageState extends State<NavigatorLoginPage> {
  @override
  void initState() {
    super.initState();
    print('LoginPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('LoginPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('LoginPage: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/products',
              arguments: 'Guest',
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print('LoginPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('LoginPage: dispose');
    super.dispose();
  }
}

class NavigatorProductsPage extends StatefulWidget {
  final String username;

  const NavigatorProductsPage({
    super.key,
    required this.username,
  });

  @override
  State<NavigatorProductsPage> createState() =>
      _NavigatorProductsPageState();
}

class _NavigatorProductsPageState
    extends State<NavigatorProductsPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200, 'isFavorite': false},
    {'name': 'Headphones', 'price': 80, 'isFavorite': false},
    {'name': 'Smartphone', 'price': 650, 'isFavorite': false},
    {'name': 'Keyboard', 'price': 45, 'isFavorite': false},
  ];

  int favoritesCount = 0;
  double screenWidth = 0;
  String? cartMessage;

  @override
  void initState() {
    super.initState();
    print('ProductsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;

    print(
      'ProductsPage: didChangeDependencies -> '
          'width: ${size.width}, height: ${size.height}',
    );
  }

  void toggleFavorite(int index) {
    setState(() {
      final wasFavorite = products[index]['isFavorite'] as bool;
      products[index]['isFavorite'] = !wasFavorite;
      favoritesCount += wasFavorite ? -1 : 1;
    });
  }

  Future<void> openProduct(int index) async {
    final product = products[index];

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => NavigatorDetailsPage(
          name: product['name'].toString(),
          price: (product['price'] as num).toDouble(),
        ),
      ),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        cartMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ProductsPage: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Text(
            'Welcome, ${widget.username}',
            style: const TextStyle(fontSize: 20),
          ),
          Text('Favorites: $favoritesCount'),
          Text('Screen width: ${screenWidth.toStringAsFixed(0)}'),
          if (cartMessage != null) Text(cartMessage!),
          Expanded(
            child: screenWidth < 600
                ? ProductsListView(
              products: products,
              onFavoritePressed: toggleFavorite,
              onProductTap: openProduct,
            )
                : ProductsGridView(
              products: products,
              onFavoritePressed: toggleFavorite,
              onProductTap: openProduct,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    print('ProductsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ProductsPage: dispose');
    super.dispose();
  }
}

class NavigatorDetailsPage extends StatefulWidget {
  final String name;
  final double price;

  const NavigatorDetailsPage({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  State<NavigatorDetailsPage> createState() =>
      _NavigatorDetailsPageState();
}

class _NavigatorDetailsPageState
    extends State<NavigatorDetailsPage> {
  @override
  void initState() {
    super.initState();
    print('DetailsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('DetailsPage: didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('DetailsPage: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '\$${widget.price}',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  '${widget.name} added to cart',
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print('DetailsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('DetailsPage: dispose');
    super.dispose();
  }
}