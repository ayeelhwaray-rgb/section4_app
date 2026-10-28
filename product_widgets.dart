import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(int) onFavoritePressed;
  final Function(int) onProductTap;

  const ProductsListView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ListTile(
          leading: const Icon(Icons.shopping_bag_outlined),
          title: Text(product['name'].toString()),
          subtitle: Text('\$${product['price']}'),
          trailing: IconButton(
            icon: Icon(
              product['isFavorite'] == true
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => onFavoritePressed(index),
          ),
          onTap: () => onProductTap(index),
        );
      },
    );
  }
}

class ProductsGridView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(int) onFavoritePressed;
  final Function(int) onProductTap;

  const ProductsGridView({
    super.key,
    required this.products,
    required this.onFavoritePressed,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          child: InkWell(
            onTap: () => onProductTap(index),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    product['name'].toString(),
                    textAlign: TextAlign.center,
                  ),
                  Text('\$${product['price']}'),
                  IconButton(
                    icon: Icon(
                      product['isFavorite'] == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () => onFavoritePressed(index),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}