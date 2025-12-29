import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductListScreen(),
    );
  }
}

/* ---------------- PRODUCT MODEL ---------------- */

class Product {
  final String name;
  final double price;
  final String image;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}

/* ---------------- SAMPLE PRODUCTS WITH IMAGES ---------------- */

List<Product> products = [
  Product(
    name: "Running Shoes",
    price: 999,
    image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
    description: "Comfortable running shoes for daily use",
  ),
  Product(
    name: "Smart Watch",
    price: 1499,
    image: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
    description: "Stylish smart watch with fitness tracking",
  ),
  Product(
    name: "College Backpack",
    price: 799,
    image: "https://images.unsplash.com/photo-1509762774605-f07235a08f1f",
    description: "Durable backpack for college students",
  ),
  Product(
    name: "Headphones",
    price: 1299,
    image: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
    description: "High quality noise cancelling headphones",
  ),
];

/* ---------------- CART ---------------- */

List<Product> cartItems = [];

/* ---------------- PRODUCT LIST SCREEN ---------------- */

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Store"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 4,
            child: Column(
              children: [
                Image.network(
                  product.image,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("₹${product.price}"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: const Text("View"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/* ---------------- PRODUCT DETAIL SCREEN ---------------- */

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              product.image,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("₹${product.price}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(product.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                cartItems.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart")),
                );
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- CART SCREEN ---------------- */

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Cart is Empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text("₹${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
