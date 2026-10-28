import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'product_widgets.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({
    super.key,
    required this.username,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200, 'isFavorite': false},
    {'name': 'Headphones', 'price': 80, 'isFavorite': false},
    {'name': 'Smartphone', 'price': 650, 'isFavorite': false},
    {'name': 'Keyboard', 'price': 45, 'isFavorite': false},
  ];

  int favoritesCount = 0;
  double screenWidth = 0;
  double screenHeight = 0;
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
    screenHeight = size.height;

    print('ProductsPage: didChangeDependencies');
    print('Screen width: $screenWidth');
    print('Screen height: $screenHeight');
  }

  void toggleFavorite(int index) {
    setState(() {
      final wasFavorite = products[index]['isFavorite'] as bool;
      products[index]['isFavorite'] = !wasFavorite;

      if (wasFavorite) {
        favoritesCount--;
      } else {
        favoritesCount++;
      }
    });
  }

  Future<void> openProduct(int index) async {
    final product = products[index];

    final result = await context.pushNamed<String>(
      'details',
      pathParameters: {
        'name': product['name'].toString(),
        'price': product['price'].toString(),
      },
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

    final isWide = screenWidth >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  'Welcome, ${widget.username}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Favorites: $favoritesCount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Screen width: ${screenWidth.toStringAsFixed(0)}',
                ),
                if (cartMessage != null)
                  Text(
                    cartMessage!,
                    style: const TextStyle(color: Colors.green),
                  ),
              ],
            ),
          ),
          Expanded(
            child: isWide
                ? ProductsGridView(
              products: products,
              onFavoritePressed: toggleFavorite,
              onProductTap: openProduct,
            )
                : ProductsListView(
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